MTTF = 100;
MTTR = 5;
comp_rep = 15;

Q = [
    -1/MTTF,              1/MTTF,            0;
    1/MTTR,  -(1/MTTR)-(1/MTTF),       1/MTTF;
    1/comp_rep,                   0,  -1/comp_rep;
];

Q = [
    -1/MTTF,              1/MTTF,            0;
    1/MTTR,  -(1/MTTR)-(1/MTTF),       1/MTTF;
    0, 0, 0;
];

p0 = [1, 0, 0];

[t, sol] = ode45(@(t,x) Q'*x, [0 10000], p0');

Q(:,1) = ones(length(Q),1);

ss_sol = [1, 0, 0] * inv(Q);