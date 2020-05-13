close all;

figure(1);
subplot(211);
plot(t,y(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('R change');
subplot(212);
plot(t,y(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('Epsilon change');