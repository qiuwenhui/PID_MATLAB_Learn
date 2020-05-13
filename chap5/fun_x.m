function F=fun(x)
tol=3;
k1=0.1;k2=0.1;

K=[k1,k2]';
C=[1,0];
A=[0 1;-1 -10];

F=det(x*eye(2)-A+K*C*exp(-tol*x));