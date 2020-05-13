clear all;
close all;
K_pid0=[0 0 0];
LB=[0 0 0];
UB=[100 100 100];
K_pid=lsqnonlin('chap2_11plant',K_pid0,LB,UB)
chap2_11sim