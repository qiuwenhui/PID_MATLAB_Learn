%PID Controler with differential in advance
clear all;
close all;

ts=20;
sys=tf([1],[60,1],'inputdelay',80);
dsys=c2d(sys,ts,'zoh');
[num,den]=tfdata(dsys,'v');

u_1=0;u_2=0;u_3=0;u_4=0;u_5=0;
ud_1=0;
y_1=0;y_2=0;y_3=0;
error_1=0;error_2=0;
ei=0;
for k=1:1:400
time(k)=k*ts;

%Linear model
y(k)=-den(2)*y_1+num(2)*u_5;

kp=0.36;kd=14;ki=0.0021;

yd(k)=1.0*sign(sin(0.00025*2*pi*k*ts));
yd(k)=yd(k)+0.05*sin(0.03*pi*k*ts);

error(k)=yd(k)-y(k);
ei=ei+error(k)*ts;

gama=0.50;
Td=kd/kp;
Ti=0.5;

c1=gama*Td/(gama*Td+ts);
c2=(Td+ts)/(gama*Td+ts);
c3=Td/(gama*Td+ts);

M=2;
if M==1      %PID Control with differential in advance
	ud(k)=c1*ud_1+c2*y(k)-c3*y_1;
	u(k)=kp*error(k)+ud(k)+ki*ei;
elseif M==2  %Simple PID Control
	u(k)=kp*error(k)+kd*(error(k)-error_1)/ts+ki*ei;
end

if u(k)>=110
   u(k)=110;
end
if u(k)<=-110
   u(k)=-110;
end
%Update parameters
u_5=u_4;u_4=u_3;u_3=u_2;u_2=u_1;u_1=u(k);
y_3=y_2;y_2=y_1;y_1=y(k);
   
error_2=error_1;
error_1=error(k);
end
figure(1);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');
figure(2);
plot(time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('u');