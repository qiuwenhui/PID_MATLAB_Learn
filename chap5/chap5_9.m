%Discrete ESO
clear all;
close all;
ts=0.001;  %Sampling time
xk=[0.15 0];
x1p_1=0;x2p_1=0;x3p_1=0;
u_1=0;x1_1=0;
for k=1:1:3000
time(k) = k*ts;
u(k)=sin(2*pi*k*ts);

tSpan=[0 ts];
para=[u(k) time(k)];              %D/A
[t,xx]=ode45('chap5_9plant',tSpan,xk,[],para);   %Plant
xk=xx(length(xx),:);   %A/D
x1(k)=xk(1); 
x2(k)=xk(2); 
th(k)=x1(k);

J=10;
dt(k)=3.0*sin(time(k));
fx(k)=-1/J*dt(k);
b=1/J;

h1=6;h2=11;h3=6;

M=3;
if M==1
    epc=0.01;
elseif M==2
    if time(k)<=1;
        R=100*time(k)^3;
    elseif time(k)>1;
        R=100;
    end
    epc=1/R;
elseif M==3
    nmn=1.0;
    R=100*(1-exp(-nmn*time(k)))/(1+exp(-nmn*time(k)));
    epc=1/R;
end
%Extended observer
x1p(k)=x1p_1+ts*(x2p_1-h1/epc*(x1p_1-th(k)));
x2p(k)=x2p_1+ts*(x3p_1-h2/epc^2*(x1p_1-th(k))+b*u(k));
x3p(k)=x3p_1+ts*(-h3/epc^3*(x1p_1-th(k)));

fxp(k)=x3p(k);

u_1=u(k);
x1_1=x1(k);
x1p_1=x1p(k);
x2p_1=x2p(k);
x3p_1=x3p(k);
end
figure(1);
subplot(211);
plot(time,th,'k',time,x1p,'r:','linewidth',2);
xlabel('time(s)');ylabel('x1 and x1p'); 
legend('position signal','position signal estimated');
subplot(212);
plot(time,x2,'k',time,x2p,'r:');
xlabel('time(s)');ylabel('x2 and x2p');
legend('speed signal','speed signal estimated');
figure(2);
plot(time,fx,'k',time,fxp,'r:');
xlabel('time(s)');ylabel('f and fp');
legend('uncertain part','uncertain part estimated');