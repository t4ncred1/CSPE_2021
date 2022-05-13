#!/usr/bin/env python3
import numpy as np
from matplotlib import pyplot as plt

rng = np.random.default_rng(seed=0xDEADBEEF)

# Uniform distribution between 10 and 20

data = rng.random(size=500)
unif = 10 + (20 - 10) * data

# Exponential with average 15

data = rng.random(size=500)
exp = -np.log(data) * 15


# Discrete distribution with the following values
#   5 with probability 0.2
#   15 with probability 0.6
#   20 with probability 0.2

data = rng.random(size=500)
discrete = []
for i in data:
    if i < 0.2:
        discrete.append(5)
    elif i < (0.2 + 0.6):
        discrete.append(15)
    else:
        discrete.append(20)


# Hyper exponential with two stages:
#   l1 = 0.1
#   l2 = 0.05
#   p = 0.5


data1 = rng.random(size=500)
data2 = rng.random(size=500)
probabilities = rng.random(size=500)
hyper = []
for i in range(0, 500):
    if probabilities[i] < 0.5:
        hyper.append(-np.log(data1[i]) / 0.1)
    else:
        hyper.append(-np.log(data2[i]) / 0.05)


# Hypo exponential with two stages:
#   l1 = 0.1
#   l2 = 0.2

data1 = rng.random(size=500)
data2 = rng.random(size=500)
hypo = -np.log(data1) / 0.1 - np.log(data2) / 0.2


# Hyper erlang with multiple branches:
#   1 stage, l = 0.02, probability 0.1
#   2 stages, l=0.2, probability 0.4
#   3 stages, l=0.25, probability 0.5
#
# NOTE: we reuse the probability vector
#   from the hyper exponential distribution

data1 = rng.random(size=500)
data2 = rng.random(size=500)
data3 = rng.random(size=500)
probabilities = rng.random(size=500)
hyper_erlang = []
for i in range(0, 500):
    if probabilities[i] < 0.1:
        hyper_erlang.append(-np.log(data1[i]) / 0.02)
    elif probabilities[i] < (0.4 + 0.1):
        hyper_erlang.append(-np.log(data1[i]) / 0.2 - np.log(data2[i]) / 0.2)
    else:
        hyper_erlang.append(
            -np.log(data1[i]) / 0.25 - np.log(data2[i]) / 0.25 - np.log(data3[i]) / 0.25
        )


# Compute average and c.v.

print("Means and coefficients of variations: ")

for (data, name) in [
    (unif, "uniform"),
    (discrete, "discrete"),
    (exp, "exponential"),
    (hyper, "hyper"),
    (hypo, "hypoexponential"),
    (hyper_erlang, "hyper erlang"),
]:

    mean = np.mean(data)
    cv = np.sqrt(np.var(data)) / mean
    print("\t" + name + ":")
    print("\t\tmean: " + str(mean))
    print("\t\tc.v.: " + str(cv))

    # Plots

    y = [*range(0, len(data))]
    y = np.divide(y, len(data))
    x = np.sort(data)

    plt.plot(x, y, label=name)
    plt.legend()

plt.show()

"""
NOTE

I c.v sono in linea con quanto ci aspettiamo:
- L'esponenziale ha un c.v. molto vicino ad 1
- L'iperesponenziale ha un c.v. più grande di 1
- La ipoesponenziale ha un c.v. più piccolo di 1
- La uniforme ha un c.v. più piccolo di 1
    -> è in linea, anche se non è ovvio.
- La iper erlang ha un c.v più grande di 1,
    perché non tutti i suoi stadi sono erlang
    a singolo stadio

"""
