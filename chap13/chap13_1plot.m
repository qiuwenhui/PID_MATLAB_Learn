close all;

figure(1);
plot(t,ur,'r',t,y(:,1),'k','linewidth',2);
legend('shaped signal','ideal signal');
xlabel('time(s)');ylabel('r');
figure(2);
plot(t,y(:,1),'r',t,y(:,2),'k','linewidth',2);
legend('ideal signal,r','out,y');
xlabel('time(s)');ylabel('r,y');

figure(3);
plot(t,ut(:,1),'r','linewidth',2);
legend('control input');
xlabel('time(s)');ylabel('ut');