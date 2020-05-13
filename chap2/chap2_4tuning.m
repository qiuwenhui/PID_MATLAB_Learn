%PID Controler Based on Ziegler-Nichols
clear all;
close all;

sys=tf(400,[1,30,200,0]);

figure(1);
rlocus(sys);
[km,pole]=rlocfind(sys)

wm=imag(pole(2));
kp=0.6*km
kd=kp*pi/(4*wm)
ki=kp*wm/pi

figure(2);
grid on;
bode(sys,'r');

sys_pid=tf([kd,kp,ki],[1,0])
sysc=series(sys,sys_pid)
hold on;
bode(sysc,'b')

figure(3);
rlocus(sysc);