%PID Controler for Square Tracking with Filtered Signal
clear all;
close all;

ts=20;
sys=tf([1],[60,1],'inputdelay',80);
dsys=c2d(sys,ts,'zoh');
[num,den]=tfdata(dsys,'v');

u_1=0;u_2=0;u_3=0;u_4=0;u_5=0;
y_1=0;
error_1=0;
ei=0;
yd_1=0;yd_2=0;
for k=1:1:1500
time(k)=k*ts;

yd(k)=1.0*sign(sin(0.00005*2*pi*k*ts));

M=1;
switch M;
case 1
   yd(k)=yd(k);
case 2
   yd(k)=0.10*yd(k)+0.80*yd_1+0.10*yd_2;
end

%Linear model
y(k)=-den(2)*y_1+num(2)*u_5;

kp=0.80;
kd=10;
ki=0.002;

error(k)=yd(k)-y(k);
ei=ei+error(k)*ts;

u(k)=kp*error(k)+kd*(error(k)-error_1)/ts+ki*ei;

%Update parameters
u_5=u_4;u_4=u_3;u_3=u_2;u_2=u_1;u_1=u(k);
y_1=y(k);
   
error_2=error_1;
error_1=error(k);
yd_2=yd_1;
yd_1=yd(k);
end
figure(1);
subplot(211);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');
subplot(212);
plot(time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');