%PID Control with Gradual approaching input value
clear all;
close all;

ts=0.001;
sys=tf(5.235e005,[1,87.35,1.047e004,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');

u_1=0;u_2=0;u_3=0;u_4=0;u_5=0;
y_1=0;y_2=0;y_3=0;
error_1=0;error_2=0;ei=0;

kp=0.50;ki=0.05;
rate=0.25;
ydi=0.0;

for k=1:1:1000
time(k)=k*ts;
R=20;  %Step Signal

%Linear model
y(k)=-den(2)*y_1-den(3)*y_2-den(4)*y_3+num(2)*u_1+num(3)*u_2+num(4)*u_3;

M=2;
if M==1   %Using simple PID
   yd(k)=R;
   error(k)=yd(k)-y(k);
end
if M==2   %Using Gradual approaching input value 
if ydi<R-0.25
   ydi=ydi+k*ts*rate;
elseif ydi>R+0.25
   ydi=ydi-k*ts*rate;
else
   ydi=R;
end   
   yd(k)=ydi;   
   error(k)=yd(k)-y(k);
end

%PID with I separation
if abs(error(k))<=0.8
   ei=ei+error(k)*ts;
else
   ei=0;
end
u(k)=kp*error(k)+ki*ei;
  
%----------Return of PID parameters------------
yd_1=yd(k);
u_3=u_2;u_2=u_1;u_1=u(k);   
y_3=y_2;y_2=y_1;y_1=y(k);
   
error_2=error_1;
error_1=error(k);
end
figure(1);
subplot(211);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');
subplot(212);
plot(time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');
figure(2);
plot(time,yd,'r','linewidth',2);
xlabel('time(s)');ylabel('ideal position value');