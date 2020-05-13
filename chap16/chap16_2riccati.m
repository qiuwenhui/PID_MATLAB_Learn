clear all;
close all;
%Single Link Inverted Pendulum Parameters
g=9.8;M=1.0;
%M=0.1;
m=0.1;L=0.5;
I=1/12*m*L^2;  
l=1/2*L;
t1=m*(M+m)*g*l/[(M+m)*I+M*m*l^2];
t2=-m^2*g*l^2/[(m+M)*I+M*m*l^2];
t3=-m*l/[(M+m)*I+M*m*l^2];
t4=(I+m*l^2)/[(m+M)*I+M*m*l^2];

A=[0,0,1,0;
   0,0,0,1;
   t1,0,0,0;
   t2,0,0,0];
B2=[0;0;t3;t4];
B1=[0;0;0.1;0.1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q1=1;q2=1;
q3=1;q4=1;
rho=1;

C1=[sqrt(q1), 0, 0, 0;
    0, sqrt(q2), 0, 0;
    0, 0, sqrt(q3), 0;
    0, 0, 0, sqrt(q4);
    0, 0, 0, 0];
D12=[0;0;0;0;sqrt(rho)];
%Continuous-time algebraic Riccati equation: Help-->search-->care
B=[B1 B2];
R=[-1 0;0 1];
C=C1;

X=care(A,B,C'*C,R)
%Verify the stability of A+(B1*B1'-B2*B2')*X
eig(A+(B1*B1'-B2*B2')*X)

K=-B2'*X