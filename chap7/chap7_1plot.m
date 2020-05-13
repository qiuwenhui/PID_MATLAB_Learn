close all;
figure(1);
subplot(211);
plot(t,y(:,1),'r',t,y(:,2),'k:','linewidth',2)
xlabel('time(s)');ylabel('Position response');
legend('ideal position signal','position response');
subplot(212);
plot(t,y(:,3),'r','linewidth',2)
xlabel('time(s)');ylabel('Speed response');

figure(2);
plot(t,ut(:,1),'r','linewidth',2)
xlabel('time(s)');ylabel('Control input');