clear all;
close all;

G=tf(133,[1 25 0]);
Kg=133/25;
Tg=1/25;
wg=1/Tg;

ph_max=60*pi/180;    %Designed maximum phase margin
alfa=((1+sin(ph_max))/cos(ph_max))^2;

wc=wg/sqrt(alfa);
wi=wg/alfa;
Kp=wc/Kg;

K=Kp*tf([1 wi],[1 0]);

figure(1);
bode(G*K);

Gc=K*G/(1+K*G);
figure(2);
step(Gc);