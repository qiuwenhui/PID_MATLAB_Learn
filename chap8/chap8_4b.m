%Fuzzy PI Control
close all;
clear all;

warning off;
a=readfis('fuzzpid');   %Load fuzzpid.fis

ts=0.001;
sys=tf(133,[1,25,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');

u_1=0;u_2=0;
y_1=0;y_2=0;
e_1=0;ec_1=0;ei=0;

kp0=0;ki0=0;
for k=1:1:1000
time(k)=k*ts;

yd(k)=1;
%Using fuzzy inference to tunning PI
k_pid=evalfis([e_1,ec_1],a);
kp(k)=kp0+k_pid(1);
ki(k)=ki0+k_pid(2);
u(k)=kp(k)*e_1+ki(k)*ei;

y(k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
e(k)=yd(k)-y(k);
%%%%%%%%%%%%%%Return of parameters%%%%%%%%%%%%%%%
u_2=u_1;u_1=u(k);  
y_2=y_1;y_1=y(k);
   
ei=ei+e(k)*ts;    % Calculating I

ec(k)=e(k)-e_1;
e_1=e(k);
ec_1=ec(k);
end
figure(1);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('ideal position','position tracking');
figure(2);
subplot(211);
plot(time,kp,'r','linewidth',2);
xlabel('time(s)');ylabel('kp');
subplot(212);
plot(time,ki,'r','linewidth',2);
xlabel('time(s)');ylabel('ki');
figure(3);
plot(time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');