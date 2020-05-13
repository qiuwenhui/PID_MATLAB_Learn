close all;
figure(1);
subplot(211);
plot(t,y(:,1),'r',t,y(:,2),'k:','linewidth',2)
xlabel('time(s)');ylabel('Position tracking');
legend('ideal position signal','position tracking');
subplot(212);
plot(t,cos(t),'r',t,y(:,3),'k:','linewidth',2)
xlabel('time(s)');ylabel('Speed tracking');
legend('ideal speed signal','Speed tracking');

figure(2);
plot(t,ut(:,1),'r','linewidth',2)
xlabel('time(s)');ylabel('Control input');

figure(3);
plot(t,y(:,4),'r',t,p(:,1),':','linewidth',2)
xlabel('time(s)');ylabel('J and its estimation');