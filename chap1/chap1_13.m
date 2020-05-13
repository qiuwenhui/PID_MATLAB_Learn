%Integration Separation PID Controller
clear all;
close all;

ts=20;
%Delay plant
sys=tf([1],[60,1],'inputdelay',80);
dsys=c2d(sys,ts,'zoh');
[num,den]=tfdata(dsys,'v');

u_1=0;u_2=0;u_3=0;u_4=0;u_5=0;
y_1=0;y_2=0;y_3=0;
error_1=0;error_2=0;
ei=0;
for k=1:1:200
time(k)=k*ts;

%Delay plant
y(k)=-den(2)*y_1+num(2)*u_5;

%I separation
yd(k)=40;
error(k)=yd(k)-y(k);
ei=ei+error(k)*ts;

M=2;
if M==1            %Using integration separation
   if abs(error(k))>=30
      beta=0.0;
   elseif abs(error(k))>=20&abs(error(k))<=30
      beta=0.6;
   elseif abs(error(k))>=10&abs(error(k))<=20
      beta=0.9;
   else
      beta=1.0;
   end
elseif M==2
       beta=1.0;   %Not using integration separation
end

kp=0.80;
ki=0.005;
kd=3.0;
u(k)=kp*error(k)+kd*(error(k)-error_1)/ts+beta*ki*ei;

if u(k)>=110       % Restricting the output of controller
   u(k)=110;
end
if u(k)<=-110
   u(k)=-110;
end

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
xlabel('time(s)');ylabel('Control input');