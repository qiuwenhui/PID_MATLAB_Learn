close all;
clear all;

h=0.001;
y_1=0;yp_1=0;
dy_1=0;

%Plant
a=25;b=133;
sys=tf(b,[1,a,0]);
dsys=c2d(sys,h,'z');
[num,den]=tfdata(dsys,'v');
u_1=0;u_2=0;
p_1=0;p_2=0;
for k=1:1:5000
t=k*h;
time(k)=t;
    
p(k)=-den(2)*p_1-den(3)*p_2+num(2)*u_1+num(3)*u_2;
dp(k)=(p(k)-p_1)/h;

yd(k)=sin(t);
dyd(k)=cos(t);
d(k)=0.5*sign(rands(1)); %Noise
if mod(k,100)==1|mod(k,100)==2
    yp(k)=p(k)+d(k);     %Practical signal      
else
    yp(k)=p(k);
end

M=1;
if M==1         %By Difference
    y(k)=yp(k);
    dy(k)=(yp(k)-yp_1)/h;
elseif M==2     %By TD
    delta=1000;
    y(k)=y_1+h*dy_1;
    dy(k)=dy_1+h*fst(y_1-yp(k),dy_1,delta,h);
end    
kp=10;kd=0.5;
u(k)=kp*(yd(k)-y(k))+kd*(dyd(k)-dy(k));

y_1=y(k);
yp_1=yp(k);
dy_1=dy(k);

u_2=u_1;u_1=u(k);
p_2=p_1;p_1=p(k);
end	
figure(1);
plot(time,p,'k',time,yp,'r:',time,y,'b:','linewidth',2);
xlabel('time(s)');ylabel('position tracking');
legend('ideal position signal','position signal with noise','position signal by TD');
figure(2);
plot(time,yd,'k',time,p,'r:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('ideal position signal','tracking signal');