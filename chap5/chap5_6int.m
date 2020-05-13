clear all;
close all;
Jp=0.0030;bp=0.067;
Jn=0.0033;bn=0.0673;
Gp=tf([1],[Jp,bp,0]);  %Practical plant
Gn=tf([1],[Jn,bn,0]);  %Nominal plant

tol=0.001;
Q=tf([3*tol,1],[tol^3,3*tol^2,3*tol,1]);
bode(Q);
dcgain(Q)
OD1=1/(1-Q);
OD2=Q/Gn;

OD3 = Q*Gn;

[num,den]=tfdata(OD2,'v');
[num1,den1]=tfdata(OD1,'v');
[num2,den2]=tfdata(OD3,'v');