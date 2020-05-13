%PID Controler Based on Ziegler-Nichols
clear all;
close all;

ts=0.25;
sys=tf(1,[10,2,0]);
dsys=c2d(sys,ts,'zoh');
[num,den]=tfdata(dsys,'v');

axis('normal'),zgrid('new');

figure(1);
rlocus(dsys);
[km,pole]=rlocfind(dsys)

wm=angle(pole(1))/ts;
kp=0.6*km
kd=kp*pi/(4*wm)
ki=kp*wm/pi

sysc=tf([kd,kp,ki],[10,2,0,0]);
dsysc=c2d(sysc,ts,'zoh');
figure(2);
rlocus(dsysc);
axis('normal'),zgrid;