%Big Delay PID Control with Smith Algorithm
clear all;close all;
Ts=20;

%Delay plant
kp=1;
Tp=60;
tol=80;
sysP=tf([kp],[Tp,1],'inputdelay',tol);   %Plant
dsysP=c2d(sysP,Ts,'zoh');
[numP,denP]=tfdata(dsysP,'v');
