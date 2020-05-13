%Low Pass Filter
clear all;
close all;

ts=0.001;
Q=tf([1],[0.04,1]);   %Low Freq Signal Filter
%Qz=c2d(Q,ts,'tucsin');
Qz=c2d(Q,ts,'tusin');
[num,den]=tfdata(Qz,'v');

y_1=0;y_2=0;
yd_1=0;yd_2=0;
for k=1:1:5000
time(k)=k*ts;

%Input Signal with noise
n(k)=0.10*sin(100*2*pi*k*ts);  %Noise signal
yd(k)=n(k)+0.50*sin(0.2*2*pi*k*ts); %Input Signal

y(k)=-den(2)*y_1+num(1)*yd(k)+num(2)*yd_1;

y_2=y_1;y_1=y(k);
yd_2=yd_1;yd_1=yd(k);
end
figure(1);bode(Q);
figure(2);
subplot(211);
plot(time,yd,'k','linewidth',2);
xlabel('time(s)');ylabel('ideal signal,yd');
subplot(212);
plot(time,y,'k','linewidth',2);
xlabel('time(s)');ylabel('filtered signal,y');