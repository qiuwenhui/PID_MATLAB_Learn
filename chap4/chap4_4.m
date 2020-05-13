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
    
p(k)=-den(2)*p_1-den(3)*p_2+num(2)*u_1+num(3)*u_2;
dp(k)=(p(k)-p_1)/T;

yd(k)=sin(t);
dyd(k)=cos(t);
d(k)=1.5*sign(rands(1)); %Noise

 if mod(k,100)==1|mod(k,100)==2
     yp(k)=p(k)+d(k);     %Practical signal      
 else
     yp(k)=p(k);
 end
yp(k)=yp(k)+0.1*rands(1);    

M=2;
if M==1         %By Difference
    y(k)=yp(k);
    dy(k)=(yp(k)-yp_1)/T;
elseif M==2     %By TD
    R=100;a0=2;b0=1;
    y(k)=y_1+T*dy_1;
    dy(k)=dy_1+T*R^2*(-a0*(y(k)-yp(k))-b0*dy_1/R);
end    
kp=10;kd=0.2;
u(k)=kp*(yd(k)-y(k))+kd*(dyd(k)-dy(k));

if M==3     %Using ideal plant
    u(k)=kp*(yd(k)-p(k))+kd*(dyd(k)-dp(k));
end

y_1=y(k);
yp_1=yp(k);
dy_1=dy(k);

u_2=u_1;u_1=u(k);
p_2=p_1;p_1=p(k);
end	
figure(1);
plot(time,p,'k',time,yp,'r-',time,y,'b:','linewidth',2);
xlabel('time(s)');ylabel('position tracking');
legend('ideal position signal','position signal with noise','position signal by TD');
figure(2);
plot(time,yd,'r',time,p,'k:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('ideal position signal','position tracking');