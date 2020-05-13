%Delay Control with Dalin Algorithm
clear all;
close all;
ts=0.5;
z=zpk('z',ts);

%Plant
Gp=tf([1],[0.4,1],'inputdelay',0.76);
Gpz=c2d(Gp,ts,'zoh');
[num1,den1]=tfdata(Gpz,'v');
H1=(z+den1(2))/(num1(1)*z+num1(2));  % 1/Gpz=z^2*H1

%Ideal closed loop
fai=tf([1],[0.15,1],'inputdelay',0.76);
faiz=c2d(fai,ts,'zoh');
Faiz=faiz/(1-faiz);
[num2,den2]=tfdata(Faiz,'v');
H2=(num2(1)*z^4+num2(2)*z^3+num2(3)*z^2)/(z^4+den2(2)*z^3+den2(3)*z^2+den2(4)*z+den2(5));  % faiz/(1-faiz)=z^(-2)*H2

%Design Dalin controller
Gcz=H1*H2;  %Gcz=1/Gpz*faiz/(1-faiz)=H1*H2
[num,den]=tfdata(Gcz,'v');

u_1=0.0;u_2=0.0;u_3=0.0;u_4=0.0;u_5=0.0;
y_1=0.0;

e_1=0.0;e_2=0.0;e_3=0.0;
ei=0;
for k=1:1:50
time(k)=k*ts;
  
yd(k)=1.0;     %Tracing Step Signal
y(k)=-den1(2)*y_1+num1(1)*u_2+num1(2)*u_3;
e(k)=yd(k)-y(k);

M=1;
if M==1        %Using Dalin Method
u(k)=num(1)*e(k)+num(2)*e_1+num(3)*e_2+num(4)*e_3-den(2)*u_1-den(3)*u_2-den(4)*u_3-den(5)*u_4-den(6)*u_5;
elseif M==2    %Using PID Method
ei=ei+e(k)*ts;
u(k)=1.0*e(k)+0.10*(e(k)-e_1)/ts+0.50*ei;
end  
%----------Return of dalin parameters------------
u_5=u_4;u_4=u_3;u_3=u_2;u_2=u_1;u_1=u(k);
y_1=y(k);

e_3=e_2;e_2=e_1;e_1=e(k);
end
figure(1);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('ideal position signal','position tracking');