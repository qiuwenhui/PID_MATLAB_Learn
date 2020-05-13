%Nonlinear PID Control for a servo system
clear all;
close all;

ts=0.001;
J=1/133;
q=25/133;
sys=tf(1,[J,q,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');

u_1=0;u_2=0;
y_1=0;y_2=0;
error_1=0;
ei=0;
for k=1:1:500
time(k)=k*ts;

yd(k)=1.0;
y(k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
error(k)=yd(k)-y(k);  
derror(k)=(error(k)-error_1)/ts; 

ap=22;bp=8.0;cp=0.8;
kp(k)=ap+bp*(1-sech(cp*error(k)));

ad=0.5;bd=2.5;cd=6.5;dd=0.30;
kd(k)=ad+bd/(1+cd*exp(dd*error(k)));

ai=1;ci=1;
ki(k)=ai*sech(ci*error(k));

ei=ei+error(k)*ts;
u(k)=kp(k)*error(k)+kd(k)*derror(k)+ki(k)*ei;

%Update Parameters
u_2=u_1;u_1=u(k);
y_2=y_1;y_1=y(k);
error_1=error(k);
end
figure(1);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('Position signal');
legend('Ideal position signal','Position tracking','location','NorthEast');
figure(2);
subplot(311);
plot(error,kp,'r','linewidth',2);xlabel('error');ylabel('kp');
subplot(312);
plot(error,kd,'r','linewidth',2);xlabel('error');ylabel('kd');
subplot(313);
plot(error,ki,'r','linewidth',2);xlabel('error');ylabel('ki');
figure(3);
subplot(311);
plot(time,kp,'r','linewidth',2);xlabel('time(s)');ylabel('kp');
subplot(312);
plot(time,kd,'r','linewidth',2);xlabel('time(s)');ylabel('kd');
subplot(313);
plot(time,ki,'r','linewidth',2);xlabel('time(s)');ylabel('ki');