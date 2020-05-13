%PD Control with TD Transient
clear all;
close all;
%h=0.001;  %Sampling time
h=0.01;

delta=50;
xk=zeros(3,1);
u_1=0;
r_1=0;
r1_1=0;r2_1=0;
for k=1:1:1000
time(k)=k*h;

p1=u_1;
p2=time(k);
tSpan=[0 h];
[tt,xx]=ode45('chap6_4plant',tSpan,xk,[],p1,p2);
xk = xx(length(xx),:);
y(k)=xk(1);
dy(k)=xk(2);

r(k)=sign(sin(k*h));
dr(k)=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TD Transient
x1=r1_1-r_1;
x2=r2_1;

r1(k)=r1_1+h*r2_1;                %Transient position signal
r2(k)=r2_1+h*fst(x1,x2,delta,h);  %Transient speed signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kp=1.0;kd=0.02;
S=1;
if S==1
    u(k)=kp*(r(k)-y(k))+kd*(dr(k)-dy(k));     %Ordinary PD
elseif S==2    %PD with TD
    u(k)=kp*(r1(k)-y(k))+kd*(r2(k)-dy(k)); 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r_1=r(k);
r1_1=r1(k);
r2_1=r2(k);

u_1=u(k);
end

if S==1
    figure(1);
    plot(time,r,'r',time,y,'k:','linewidth',2);
    legend('Ideal position signal','Position signal tracking');
    xlabel('time(s)'),ylabel('r,y');
elseif S==2
    figure(1);
    subplot(211);
    plot(time,r,'r',time,r1,'k:','linewidth',2);
    legend('Ideal position signal','Transient position signal');
    xlabel('time(s)'),ylabel('position signal');
    subplot(212);
    plot(time,r2,'r','linewidth',2);
    legend('Transient speed signal');
    xlabel('time(s)'),ylabel('speed signal');
    figure(2);
    plot(time,r1,'r',time,y,'k:','linewidth',2);
    legend('Transient position signal','Position signal tracking');
    xlabel('time(s)'),ylabel('r,r1,y');
end