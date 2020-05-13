%State Feedback Control for Single Link Inverted Pendulum
clear all;
close all;
global A B C D

%Single Link Inverted Pendulum Parameters
g=9.8;M=1.0;m=0.1;L=0.5;Fc=0.0005;Fp=0.000002;

I=1/12*m*L^2;  
l=1/2*L;
t1=m*(M+m)*g*l/[(M+m)*I+M*m*l^2];
t2=-m^2*g*l^2/[(m+M)*I+M*m*l^2];
t3=-m*l/[(M+m)*I+M*m*l^2];
t4=(I+m*l^2)/[(m+M)*I+M*m*l^2];

A=[0,1,0,0;
   t1,0,0,0;
   0,0,0,1;
   t2,0,0,0];
B=[0;t3;0;t4];
C=[1,0,0,0;
   0,0,1,0];
D=[0;0];

M=1;
if M==1
    Q=[100,0,0,0;   %100,10,1,1 express importance of theta,dtheta,x,dx
       0,10,0,0;
       0,0,1,0;
       0,0,0,1];
    R=[0.1];
    K=LQR(A,B,Q,R); %LQR Gain    
elseif M==2  % Pole point placement
    P=[-10-10i -10+10i -10 -20];     %Stable pole point
    K=place(A,B,P);
end

u_1=0;
xk=[-10/57.3,0,0.20,0];   %Initial state
ts=0.02;
for k=1:1:1000
time(k)=k*ts;
Tspan=[0 ts];

para=u_1;
[t,x]=ode45('chap17_3plant',Tspan,xk,[],para);
xk=x(length(x),:);

x1(k)=xk(1);
x2(k)=xk(2);
x3(k)=xk(3);
x4(k)=xk(4);
x=[x1(k) x2(k) x3(k) x4(k)]';

u(k)=-K*x;  %LQR
u_1=u(k);
end
figure(1);
subplot(211);
plot(time,x1,'k','linewidth',2);
xlabel('time(s)');ylabel('Pendulum Angle response');
subplot(212);
plot(time,x2,'k','linewidth',2);
xlabel('time(s)');ylabel('Pendulum Angle speed response');

figure(2);
subplot(211);
plot(time,x3,'k','linewidth',2);
xlabel('time(s)');ylabel('Cart position response');
subplot(212);
plot(time,x4,'k','linewidth',2);
xlabel('time(s)');ylabel('Cart speed response');

figure(3);
plot(time,u,'k','linewidth',2);
xlabel('time(s)');ylabel('Control input');