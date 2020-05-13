%Discrete Levant TD
close all; 
clear all; 
T=0.001; 
y_1=0;dy_1=0; 
for k=1:1:10000 
    t=k*T; 
    time(k)=t; 

    u(k)=sin(k*T); 
    du(k)=cos(k*T);  

    d(k)=0.5; %Noise 
    d(k)=-0.5; %Noise 
    d(k)=0.5*sign(rands(1)); %Noise
if mod(k,100)==1
   up(k)=u(k)+1*d(k); %Practical signal
else 
   up(k)=u(k); 
end 
up(k)=up(k)+0.15*rands(1);

alfa=8;nmna=6;      %M=1   Low Frequency

y(k)=y_1+T*(dy_1-nmna*sqrt(abs(y_1-up(k)))*sign(y_1-up(k))); 
dy(k)=dy_1-T*alfa*sign(y_1-up(k)); 

y_1=y(k); dy_1=dy(k); 
end 
figure(1); 
subplot(211);
plot(time,u,'r',time,up,'k:','linewidth',2); 
xlabel('time(s)'),ylabel('input signal'); 
legend('sin(t)','signal with noises');
subplot(212);
plot(time,u,'r',time,y,'k:','linewidth',2); 
xlabel('time(s)'),ylabel('input signal'); 
legend('sin(t)','signal with TD');

figure(2); 
plot(time,du,'r',time,dy,'k:','linewidth',2); 
xlabel('time(s)'),ylabel('derivative estimation');
legend('cos(t)','x2 by Levant differentiator');