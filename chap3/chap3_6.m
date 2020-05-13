%Big Delay PID Control with Smith Algorithm
clear all;close all;
Ts=20;

%Delay plant
kp=1;
Tp=60;
tol=80;
sysP=tf([kp],[Tp,1],'inputdelay',tol);   %Plant
dsysP=c2d(sysP,Ts,'zoh');
[numP,denP]=tfdata(dsysP,'v');

M=1;
%Prediction model
if M==1  %No Precise Model: PI+Smith
   kp1=kp*1.10;
   Tp1=Tp*1.10;
   tol1=tol*1.0;
elseif M==2|M==3  %Precise Model: PI+Smith
   kp1=kp;
   Tp1=Tp;
   tol1=tol;
end

sysHO=tf([kp1],[Tp1,1]);  %Model without delay
dsysHO=c2d(sysHO,Ts,'zoh');
[numHO,denHO]=tfdata(dsysHO,'v');

sysHP=tf([kp1],[Tp1,1],'inputdelay',tol1);  %Model with delay
dsysHP=c2d(sysHP,Ts,'zoh');
[numHP,denHP]=tfdata(dsysHP,'v');

u_1=0.0;u_2=0.0;u_3=0.0;u_4=0.0;u_5=0.0;
e1_1=0;
e2=0.0;
e2_1=0.0;
ei=0;

xm_1=0.0;
ym_1=0.0;
y_1=0.0;

for k=1:1:600
    time(k)=k*Ts;
   
yd(k)=sign(sin(0.0002*2*pi*k*Ts));  %Tracing Square Wave Signal

y(k)=-denP(2)*y_1+numP(2)*u_5;   %GP(z):Practical Plant

%Prediction model
xm(k)=-denHO(2)*xm_1+numHO(2)*u_1;  %GHO(z):Without Delay 
ym(k)=-denHP(2)*ym_1+numHP(2)*u_5;  %GHP(z):With Delay 

if M==1       %No Precise Model: PI+Smith
    e1(k)=yd(k)-y(k);
    e2(k)=e1(k)-xm(k)+ym(k);
	ei=ei+Ts*e2(k);
	u(k)=0.50*e2(k)+0.010*ei;
    e1_1=e1(k);
elseif M==2   %Precise Model: PI+Smith
    e2(k)=yd(k)-xm(k);
	ei=ei+Ts*e2(k);
	u(k)=0.50*e2(k)+0.010*ei;    
	e2_1=e2(k);
elseif M==3  %Only PI
   e1(k)=yd(k)-y(k);
	ei=ei+Ts*e1(k);
	u(k)=0.50*e1(k)+0.010*ei;   
   e1_1=e1(k);
end

%----------Return of smith parameters------------
xm_1=xm(k);
ym_1=ym(k);

u_5=u_4;u_4=u_3;u_3=u_2;u_2=u_1;u_1=u(k);
y_1=y(k);
end
figure(1);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('ideal position signal','position tracking');