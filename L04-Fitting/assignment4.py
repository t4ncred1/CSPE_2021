#!/usr/bin/env python3
import csv
import numpy as np
from scipy.optimize import root
from scipy.optimize import minimize
from matplotlib import pyplot as plt


# Obtain the data
data = csv.reader(open("../Assignment and Dataset/Traces.csv"))
data = [[float(x) for x in row] for row in data]
data = np.transpose(data)

# find the moments
# Three should be enough, since the maximal number of parameters to fit
# is 3 for the hyper-exponential
m1 = np.mean(data, 1)
m2 = np.mean([[x**2 for x in row] for row in data], 1)
m3 = np.mean([[x**3 for x in row] for row in data], 1)


#######################
#  METHOD OF MOMENTS  #
#######################

#   Uniform

def mm_Unif_pars(moment1, moment2):
    a = moment1 - 1/2*(np.sqrt(12*(moment2-moment1**2)))
    b = moment1 + 1/2*(np.sqrt(12*(moment2-moment1**2)))
    return [a, b]

#   exponential
def mm_exp_pars(moment1):
    l = 1/moment1
    return l


#   hyper exponential
def mm_hyper_pars(moment1, moment2, moment3, start):
    def hyper_eqs(par):
        lambda1, lambda2, p = par
        if lambda1<0:
            return (1000 + abs(lambda1), 1000 + abs(lambda1), 1000 + abs(lambda1))
        if lambda2<0:
            return (1000 + abs(lambda2), 1000 + abs(lambda2), 1000 + abs(lambda2))
        if p>1:
            return (1000 + abs(p), 1000 + abs(p), 1000 + abs(p))
        if p<0:
            return (1000 + abs(p), 1000 + abs(p), 1000 + abs(p))

        return[((p/lambda1 + (1-p)/lambda2))/moment1-1,
               (2*(p/(lambda1**2) + (1-p)/(lambda2**2)))/moment2-1,
               (6*(p/(lambda1**3) + (1-p)/(lambda2**3)))/moment3-1]

    sol = root(hyper_eqs, start, method='lm')
    # print("This should be a value near zero(hyper): ", hyper_eqs(sol.x))
    return sol.x


#   hypo exponential
def mm_hypo_pars(moment1, moment2, start):
    def hypo_eqs(par):
        lambda1, lambda2 = par
        return((1/lambda1 + 1/lambda2)/moment1 - 1,
               (1/lambda1**2 + 1/lambda2**2)/moment2 - 1)
    sol = root(hypo_eqs, start, method='lm')
    # print("This should be a value near zero(hypo): ", hypo_eqs(sol.x))
    return sol.x



#   create three arrays with all the values
#   NOTE: in the case of the hyperexponential, since I wasn't capable of
#   putting a constraint on the result, I had to use different starting points
mm_Exp = []
mm_Unif = []
mm_Hyper = []
mm_Hypo = []
for i, _ in enumerate(m1):
    mm_Unif.append(mm_Unif_pars(m1[i], m2[i]))
    mm_Exp.append(mm_exp_pars(m1[i]))
    mm_Hypo.append(mm_hypo_pars(m1[i],  m2[i],  [0.5,  0.5]))
    if i != 2:
        mm_Hyper.append(mm_hyper_pars(m1[i], m2[i], m3[i], [0.5, 0.5, 0.5]))
    else:
        mm_Hyper.append(mm_hyper_pars(m1[i], m2[i], m3[i], [0.5, 0.5, 0.0]))

print("\nMoments estimated parameters:\n")

for i in range(0,4):
    print("\tDataset ", str(i+1))
    print("\t\tUnif:")
    print("\t\t\ta:\t", mm_Unif[i][0])
    print("\t\t\tb:\t", mm_Unif[i][1])
    print("\t\tExp:")
    print("\t\t\tl:\t", mm_Exp[i])
    print("\t\tHyper:")
    print("\t\t\tl1:\t", mm_Hyper[i][0])
    print("\t\t\tl2:\t", mm_Hyper[i][1])
    print("\t\t\tp:\t", mm_Hyper[i][2])
    print("\t\tHypo:")
    print("\t\t\tl1:\t", mm_Hypo[i][0])
    print("\t\t\tl2:\t", mm_Hypo[i][1])

######################
# MAXIMUM LIKELIHOOD #
######################

#   exponential
def ml_exp_pars(start, values):

    def exp_eqs(lamb):
        return (-len(values)*np.log(lamb)) + (lamb*np.sum(values))

    sol = minimize(exp_eqs, x0=start, bounds=[(0, np.Inf)])
    return sol.x

def ml_exp_pars_alt(values):
   return(len(values)/np.sum(values))


#   hyperexp
def ml_hyper_pars(start, values):
    def hyper_eqs(par):
        [l1, l2, p] = par
        alt_values = [np.log(p*l1*np.exp(-l1*x)+(1-p)*l2*np.exp(-l2*x)) for x in values]
        return -np.sum(alt_values)
    sol = minimize(hyper_eqs, x0=start, bounds=[(0.01, np.Inf), (0.01, np.Inf), (0.01,1)])
    return sol.x


#   hypoexp
def ml_hypo_pars(start, values):
    def hypo_eqs(par):
        [l1, l2] = par
        alt_values = [np.log(l1*l2/(l1-l2)*(np.exp(-l2*x)-np.exp(-l1*x))) for x in values]
        return -np.sum(alt_values)
    sol = minimize(hypo_eqs, x0=start, bounds=[(0.01, np.Inf), (0.01, np.Inf)])
    return sol.x

#   create three arrays with all the values
ml_Exp = []
ml_Hyper = []
ml_Hypo = []
for i in range(0,4):
    ml_Exp.append(ml_exp_pars(mm_Exp[i], data[i]))
    ml_Hypo.append(ml_hypo_pars(mm_Hypo[i], data[i]))
    ml_Hyper.append(ml_hyper_pars(mm_Hyper[i], data[i]))

print("\nMaximum Likelihood estimated parameters:\n")
for i in range(0,4):
    print("\tDataset ", str(i+1))
    print("\t\tExp:")
    print("\t\t\tl:\t", ml_Exp[i][0])
    print("\t\tHyper:")
    print("\t\t\tl1:\t", ml_Hyper[i][0])
    print("\t\t\tl2:\t", ml_Hyper[i][1])
    print("\t\t\tp:\t", ml_Hyper[i][2])
    print("\t\tHypo:")
    print("\t\t\tl1:\t", ml_Hypo[i][0])
    print("\t\t\tl2:\t", ml_Hypo[i][1])

#########
# PLOTS #
#########

for i in range(0,4):
    fig, ((hyper, hypo), (exp, unif)) = plt.subplots(2, 2)

    fig.suptitle('Dataset '+str(i+1))

    # common

    ydata = [*range(0,len(data[i]))]
    ydata = np.divide(ydata,len(data[i]))
    xdata = np.sort(data[i])

    xlin  = np.linspace(start=np.min(data[i]), stop=np.max(data[i]))

    # hyper-exponential

    hyper.set_title("hyper-exponential")

        # data

    hyper.plot(xdata, ydata, label='data')

        # moments

    [l1, l2, p] = mm_Hyper[i]
    y = 1 - (p*np.exp(-l1*xlin) + (1-p)*np.exp(-l2*xlin))
    hyper.plot(xlin, y, label='moments' )

        # mle

    [l1, l2, p] = ml_Hyper[i]
    y = 1 - (p*np.exp(-l1*xlin) + (1-p)*np.exp(-l2*xlin))
    hyper.plot(xlin, y, label='maximum likelihood' )

    hyper.legend();

    # hypo-exponential

    hypo.set_title("hypo-exponential")

        # data

    hypo.plot(xdata, ydata, label='data')

        # moments

    [l1, l2] = mm_Hypo[i]
    y = 1 - l2*np.exp(-l1*xlin)/(l2-l1) + l1*np.exp(-l2*xlin)/(l2-l1)
    hypo.plot(xlin, y, label='moments' )

        # mle

    [l1, l2] = ml_Hypo[i]
    y = 1 - l2*np.exp(-l1*xlin)/(l2-l1) + l1*np.exp(-l2*xlin)/(l2-l1)
    hypo.plot(xlin, y, label='maximum likelihood' )

    hypo.legend();

    # exponential

    exp.set_title("exponential")

        # data

    exp.plot(xdata, ydata, label='data')

        # moments

    l = mm_Exp[i]
    y = 1 - np.exp(-l*xlin)
    exp.plot(xlin, y, label='moments')

        # mle

    [l] = ml_Exp[i]
    y = 1 - np.exp(-l*xlin)
    exp.plot(xlin, y, label='maximum likelihood')

    exp.legend()

    # uniform

    unif.set_title("uniform")

        # data

    unif.plot(xdata, ydata, label='data')

        # moments

    [a, b] = mm_Unif[i]

    # y = (xlin-a)/(b-a)
    y = []
    for x in xlin:
        if x<a:
            y.append(0)
        elif x>b:
            y.append(1)
        else:
            y.append((x-a)/(b-a))

    unif.plot(xlin, y, label='moments')

    unif.legend()

plt.show();


"""
NOTE

L'esponenziale calcolato con il metodo dei momenti e quello calcolato con il
metodo di massima somiglianza sono sempre uguali perché il metodo dei momenti
raggiunge subito il miglior valore possibile per lambda.
"""
