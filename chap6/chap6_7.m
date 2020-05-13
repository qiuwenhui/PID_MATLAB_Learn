clear all;
close all;

T=0.01;  %Sampling time
beta1=100;beta2=300;beta3=1000;
delta=T;
alfa1=0.5;alfa2=0.25;

xk=zeros(2,1);
e1_1=0;
u_1=0;
r_1=0;
z1_1=0;z2_1=0;z3_1=0;
for k=1:1:2000
time(k)=k*T;

p=u_1;
tSpan=[0 T];
[tt,xx]=ode45('chap6_7plant',tSpan,xk,[],p);
xk = xx(length(xx),:);
y(k)=xk(1);
dy(k)=xk(2);

u(k)=sin(k*T);
dr(k)=0;

f(k)=-25*dy(k);    %Uunknown part
b=133;

x3(k)=f(k);
%ESO
epc0=z1_1-y(k);
z1(k)=z1_1+T*(z2_1-beta1*epc0);
z2(k)=z2_1+T*(z3_1-beta2*fal(epc0,alfa1,delta)+b*u(k));
z3(k)=z3_1-T*beta3*fal(epc0,alfa2,delta);

z1_1=z1(k);
z2_1=z2(k);
z3_1=z3(k);

z1_1=z1(k);z2_1=z2(k);z3_1=z3(k);
u_1=u(k);
end
figure(1);
subplot(211);
plot(time,y,'k',time,z1,'r:','linewidth',2);
xlabel('time(s)');ylabel('position value');
legend('practical position signal', 'position signal estimation');
subplot(212);
plot(time,dy,'k',time,z2,'r:','linewidth',2);
xlabel('time(s)');ylabel('speed value');
legend('practical speed signal', 'speed signal estimation');
figure(2);
plot(time,x3,'k',time,z3,'r:','linewidth',2);
xlabel('time(s)');ylabel('total uncertainties and its estimate');
legend('practical unceratin part', 'unceratin part estimation');