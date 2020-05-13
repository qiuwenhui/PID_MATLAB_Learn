clear all;
close all;

ts=0.001;
%Low Filter
Q=tf([1],[0.04,1]);
Qz=c2d(Q,ts,'tustin');
[numQ,denQ]=tfdata(Qz,'v');

%Plant
sys=tf(5.235e005,[1,87.35,1.047e004,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');

kp=0.20;
ki=0.05;