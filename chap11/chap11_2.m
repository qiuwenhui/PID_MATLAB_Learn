%PID Control with Stribeck Friction Model
clear all;
close all;
global w A alfa J Ce R Km Ku S a1 Fm Fc M kv

%Servo system Parameters
J=0.6;Ce=1.2;Km=6;
Ku=11;R=7.77;

A=0.10;
w=1*2*pi;

alfa=0.01;

T=1.0;
ts=0.001;  %Sampling time
TimeSet=[0:ts:T];

M=1;       %If M=0, No Friction works
S=1;
[t,x]=ode45('chap11_2plant',TimeSet,[0,0,0]);
x1=x(:,1);
x2=x(:,2);
x3=x(:,3);

if S==1
   yd=A*sin(w*t);
   dyd=A*w*cos(w*t);
   ddyd=-A*w*w*sin(w*t);
   error=yd-x(:,1);
   derror=dyd-x(:,2);
end
if S==2
  for kk=1:1:T/ts+1
      yd(kk)=1;
      dyd(kk)=0;
      ddyd(kk)=0;
      error(kk)=yd(kk)-x1(kk);
      derror(kk)=dyd(kk)-x2(kk);
  end
end
if S==3
  for kk=1:1:T/ts+1
      yd=A*sign(sin(0.4*2*pi*t));
      dyd(kk)=0;
      ddyd(kk)=0;
      error(kk)=yd(kk)-x1(kk);
      derror(kk)=dyd(kk)-x2(kk);
  end
end

F=J*x(:,3);
x2=x(:,2);
for kk=1:1:T/ts+1
   time(kk)=(kk-1)*ts;
   
if abs(x2(kk))<=alfa
   if F(kk)>Fm
      Ff(kk)=Fm;
   elseif F(kk)<-Fm
      Ff(kk)=-Fm;
   else
      Ff(kk)=F(kk);
   end      
end
   
if x2(kk)>alfa
   Ff(kk)=Fc+(Fm-Fc)*exp(-a1*x2(kk))+kv*x2(kk);
elseif x2(kk)<-alfa
   Ff(kk)=-Fc-(Fm-Fc)*exp(a1*x2(kk))+kv*x2(kk);
end

if M==0
   Ff(kk)=0;  %No Friction
end

u(kk)=200*error(kk)+40*derror(kk);   %PID Control

if u(kk)>=10   
   u(kk)=10;
end
if u(kk)<=-10
   u(kk)=-10;
end
end
figure(1);
plot(t,yd,'r',t,x(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('position tracking');
legend('ideal position signal','position tracking');
figure(2);
plot(t,dyd,'r',t,x(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('speed tracking');
legend('ideal speed signal','speed tracking');
figure(3);
plot(t,error,'r','linewidth',2);
xlabel('time(s)');ylabel('error');
figure(4);
plot(x(:,2),Ff,'r','linewidth',2);
xlabel('speed');ylabel('Friction');
figure(5);
plot(t,Ff,'r','linewidth',2);
xlabel('time(s)');ylabel('Friction');
figure(6);
plot(time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');