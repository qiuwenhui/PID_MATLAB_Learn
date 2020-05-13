clear all;
close all;
h=0.01;  %Sampling time
%ESO Parameters
beta1=100;beta2=300;beta3=1000;
delta1=0.0025;
alfa1=0.5;alfa2=0.25;

kp=10;kd=0.3;

xk=zeros(2,1);
u_1=0;
z1_1=0;z2_1=0;z3_1=0;
for k=1:1:2000
time(k) = k*h;

p1=u_1;
p2=k*h;
tSpan=[0 h];
[tt,xx]=ode45('chap6_9plant',tSpan,xk,[],p1,p2);
xk = xx(length(xx),:);
y(k)=xk(1);
dy(k)=xk(2);

yd(k)=sin(k*h);
dyd(k)=cos(k*h);

f(k)=-25*dy(k)+33*sin(pi*p2);    %Uunknown part
b=133;
x3(k)=f(k);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ESO
e=z1_1-y(k);
z1(k)=z1_1+h*(z2_1-beta1*e);
z2(k)=z2_1+h*(z3_1-beta2*fal(e,alfa1,delta1)+b*u_1);
z3(k)=z3_1-h*beta3*fal(e,alfa2,delta1);

z1_1=z1(k);
z2_1=z2(k);
z3_1=z3(k);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disturbance compensation
e1(k)=yd(k)-z1(k);
e2(k)=dyd(k)-z2(k);

M=1;
if M==1     %With ESO Compensation
    u(k)=kp*(yd(k)-y(k))+kd*(dyd(k)-dy(k))-z3(k)/b;
elseif M==2 %Without ESO Compensation
    u(k)=kp*(yd(k)-y(k))+kd*(dyd(k)-dy(k));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z1_1=z1(k);z2_1=z2(k);z3_1=z3(k);
u_1=u(k);
end
figure(1);
subplot(211);
plot(time,yd,'k',time,y,'r:','linewidth',2);
xlabel('time(s)'),ylabel('position signal');
legend('ideal position signal','position tracking');
subplot(212);
plot(time,yd-y,'r','linewidth',2);
xlabel('time(s)'),ylabel('position tracking error');
legend('tracking signal error');
figure(2);
subplot(311);
plot(time,z1,'k',time,y,'r:','linewidth',2);
xlabel('time(s)'),ylabel('z1,y');
legend('practical position signal', 'position signal estimation');    
subplot(312);
plot(time,z2,'k',time,dy,'r:','linewidth',2);
xlabel('time(s)'),ylabel('z2,dy');
legend('practical speed signal', 'speed signal estimation');    
subplot(313);
plot(time,z3,'k',time,x3,'r:','linewidth',2);
xlabel('time(s)'),ylabel('z3,x3');
legend('practical uncertain part', 'uncertain part estimation'); 