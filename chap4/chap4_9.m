%PID based on Discrete Levant TD
close all;
clear all;

T=0.001;
y_1=0;yp_1=0;
dy_1=0;

%Plant
a=25;b=133;
sys=tf(b,[1,a,0]);
dsys=c2d(sys,T,'z');
[num,den]=tfdata(dsys,'v');
u_1=0;u_2=0;
p_1=0;p_2=0;
for k=1:1:5000
t=k*T;
time(k)=t;
    
yd(k)=sin(t);
dyd(k)=cos(t);
p(k)=-den(2)*p_1-den(3)*p_2+num(2)*u_1+num(3)*u_2;

d(k)=0.5*sign(rands(1));
if mod(k,100)==1|mod(k,100)==2
    yp(k)=p(k)+d(k);     %Practical signal      
else
    yp(k)=p(k);
end

M=2;
if M==1         %By Difference
    y(k)=yp(k);
    dy(k)=(yp(k)-yp_1)/T;
elseif M==2     %By TD
    alfa=8;nmna=6;
    y(k)=y_1+T*(dy_1-nmna*sqrt(abs(y_1-yp(k)))*sign(y_1-yp(k))); 
    dy(k)=dy_1-T*alfa*sign(y_1-yp(k)); 
end    
kp=10;kd=0.1;
u(k)=kp*(yd(k)-y(k))+kd*(dyd(k)-dy(k));

y_1=y(k);
yp_1=yp(k);
dy_1=dy(k);

u_2=u_1;u_1=u(k);
p_2=p_1;p_1=p(k);
end	
if M==1        %By Difference
figure(1);
plot(time,yd,'k',time,p,'r:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('ideal position signal','position tracking');
elseif M==2    %By TD
figure(1);
subplot(211);
plot(time,p,'k',time,yp,'r:',time,y,'b:','linewidth',2);
xlabel('time(s)');ylabel('position signal');
legend('ideal position signal','position signal with noise','position signal by TD');
subplot(212);
plot(time,dy,'k','linewidth',2);
xlabel('time(s)');ylabel('speed signal');
legend('speed signal by TD');
figure(2);
plot(time,yd,'r',time,p,'k:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('ideal position signal','position tracking');
end