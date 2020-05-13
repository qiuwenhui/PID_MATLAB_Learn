close all;
figure(1);
plot(t,y(:,1),'r',t,y(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('y,ye');
legend('ideal signal','filtered signal');

figure(2);
plot(t,y(:,1),'r',t,y1(:,1),'k:','linewidth',2);
xlabel('time(s)');ylabel('y,yv');
legend('ideal signal','signal with noise');