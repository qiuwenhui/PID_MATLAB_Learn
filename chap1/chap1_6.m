%Discrete PID control for continuous plant
clear all;
close all;

ts=0.001;  %Sampling time
xk=zeros(2,1);
e_1=0;
u_1=0;
% ??
for k=1:1:2000
time(k) = k*ts;

yd(k)=0.50*sin(1*2*pi*k*ts);
  
para=u_1;
tSpan=[0 ts];
[tt,xx]=ode45('chap1_6plant',tSpan,xk,[],para);
xk = xx(length(xx),:);

y(k)=xk(1); 

% 
e(k)=yd(k)-y(k);

de(k)=(e(k)-e_1)/ts; 

% PD
u(k)=20.0*e(k)+0.50*de(k);
%Control limit  ??
if u(k)>10.0
   u(k)=10.0;
end
if u(k)<-10.0
   u(k)=-10.0;
end

u_1=u(k);
e_1=e(k);
end
figure(1);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');
figure(2);
plot(time,yd-y,'r','linewidth',2);
xlabel('time(s)'),ylabel('error');