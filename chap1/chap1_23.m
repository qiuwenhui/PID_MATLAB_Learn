%PID Feedforward Controler
clear all;
close all;

ts=0.001;
sys=tf(133,[1,25,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');

u_1=0;u_2=0;
y_1=0;y_2=0;

error_1=0;ei=0;
for k=1:1:1000
time(k)=k*ts;
   
A=0.5;F=3.0;
yd(k)=A*sin(F*2*pi*k*ts); 
dyd(k)=A*F*2*pi*cos(F*2*pi*k*ts);
ddyd(k)=-A*F*2*pi*F*2*pi*sin(F*2*pi*k*ts);

%Linear model
y(k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;

error(k)=yd(k)-y(k);

ei=ei+error(k)*ts;

up(k)=80*error(k)+20*ei+2.0*(error(k)-error_1)/ts;

uf(k)=25/133*dyd(k)+1/133*ddyd(k);

M=2;
if M==1        %Only using PID
	u(k)=up(k);
elseif M==2    %PID+Feedforward
	u(k)=up(k)+uf(k);
end

if u(k)>=10
   u(k)=10;
end
if u(k)<=-10
   u(k)=-10;
end

u_2=u_1;u_1=u(k);
y_2=y_1;y_1=y(k);
error_1=error(k);
end
figure(1);
subplot(211);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');
subplot(212);
plot(time,error,'r','linewidth',2);
xlabel('time(s)');ylabel('error');
figure(2);
plot(time,up,'k',time,uf,'b',time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('up,uf,u');