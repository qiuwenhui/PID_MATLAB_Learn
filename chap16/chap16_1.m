clear all;
close all;

A=[-2.548 9.1 0;1 -1 1;0 -14.2 0];
B=[1 0 0;0 1 0;0 0 1];
F=sdpvar(3,3);
M=sdpvar(3,3);
P=1000000*eye(3);

FAI=(A'+F'*B')*P+P*(A+B*F);

%LMI description
L=set(FAI<0);
solvesdp(L);
F=double(F)