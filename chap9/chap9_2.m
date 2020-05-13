%Single Neural Net PID Controller based on Second Type Learning Algorithm 
clear all;
close all;

xc=[0,0,0]';

K=0.02;P=2;Q=1;d=6;

xiteP=120;
xiteI=4;
xiteD=159;

%Initilizing kp,ki and kd
wkp_1=rand;
wki_1=rand;
wkd_1=rand;

wkp_1=0.34;
wki_1=0.32;
wkd_1=0.33;

error_1=0;error_2=0; 
y_1=0;y_2=0;
u_1=0.1726;u_2=0;u_3=0;u_4=0;u_5=0;u_6=0;u_7=0;

ts=0.001;
for k=1:1:250
    time(k)=k*ts;
    yd(k)=1.0;                           %Tracing Step Signal

ym(k)=0; 
if k==100
   ym(k)=0.10;  %Disturbance
end
y(k)=0.368*y_1+0.26*y_2+u_6+0.632*u_7+ym(k);
error(k)=yd(k)-y(k);

wx=[wkp_1,wkd_1,wki_1];
wx=wx*xc;

b0=y(1);
K=0.0175;   
wkp(k)=wkp_1+xiteP*K*[P*b0*error(k)*xc(1)-Q*K*wx*xc(1)];
wki(k)=wki_1+xiteI*K*[P*b0*error(k)*xc(2)-Q*K*wx*xc(2)];
wkd(k)=wkd_1+xiteD*K*[P*b0*error(k)*xc(3)-Q*K*wx*xc(3)];
   
   xc(1)=error(k)-error_1;               %P
   xc(2)=error(k);                         %I
   xc(3)=error(k)-2*error_1+error_2;   %D

   wadd(k)=abs(wkp(k))+abs(wki(k))+abs(wkd(k));
   w11(k)=wkp(k)/wadd(k);
   w22(k)=wki(k)/wadd(k);
   w33(k)=wkd(k)/wadd(k);
   w=[w11(k),w22(k),w33(k)];
   
u(k)=u_1+K*w*xc;     % Control law

if u(k)>10
   u(k)=10;
end   
if u(k)<-10
   u(k)=-10;
end   
  
error_2=error_1;
error_1=error(k);

u_7=u_6;u_6=u_5;u_5=u_4;u_4=u_3;
u_3=u_2;u_2=u_1;u_1=u(k);
   
wkp_1=wkp(k);
wkd_1=wkd(k);
wki_1=wki(k);
   
y_2=y_1;y_1=y(k);
end
figure(1);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('ideal position','position tracking');
figure(2);
plot(time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('u');
figure(3);
subplot(311);
plot(time,wkp,'r','linewidth',2);
xlabel('time(s)');ylabel('wkp');
subplot(312);
plot(time,wki,'r','linewidth',2);
xlabel('time(s)');ylabel('wki');
subplot(313);
plot(time,wkd,'r','linewidth',2);
xlabel('time(s)');ylabel('wkd');