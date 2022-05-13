clearvars;
data = readmatrix("Traces.csv");

[m1, m2, m3, m4] = moments(data);

Unif_pars = [m1 - 1/2*(sqrt(12*(m2-m1.^2)));
                m1 + 1/2*(sqrt(12*(m2-m1.^2)))];

Exp_pars = m1.^(-1);

Hyper_pars_1 = fsolve(@(x)mm_hyper_pars(x, m1(1), m2(1), m3(1)), [0.5, 0.5, 0.5]);
Hyper_pars_2 = fsolve(@(x)mm_hyper_pars(x, m1(2), m2(2), m3(2)), [0.5, 0.5, 0.5]);
Hyper_pars_3 = fsolve(@(x)mm_hyper_pars(x, m1(3), m2(3), m3(3)), [0.5, 0.5, 0.5]);
Hyper_pars_4 = fsolve(@(x)mm_hyper_pars(x, m1(4), m2(4), m3(4)), [0.5, 0.5, 0.5]);

plot(sort(data(:,2)), (1:length(data(:,2)))/length(data(:,2)), 'b*-');
hold on
x = (0:max(data(:,2))*10)/10;
y = 1-Hyper_pars_2(3)*exp(-x*Hyper_pars_2(1))-(1-Hyper_pars_2(3))*exp(-x*Hyper_pars_2(2));
plot(x, y,'r*-');
hold off

function [m1, m2, m3, m4] = moments(data)
    m1 = sum(data)/length(data);
    m2 = sum(data.^2)/length(data);
    m3 = sum(data.^3)/length(data);
    m4 = sum(data.^4)/length(data);
end

function F = mm_hyper_pars(x, m1, m2, m3)
    l1 = x(1);
    l2 = x(2);
    p = x(3);
    
    F(1) = (p/l1 + (1-p)/l2)/m1 - 1;
    F(2) = (2*(p/l1^2) + (1-p)/(l2^2))/m2 -1;
    F(3) = (6*(p/l1^3) + (1-p)/(l2^3))/m3 -1;
end