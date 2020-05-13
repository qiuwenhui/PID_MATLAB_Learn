close all;

figure(1);
plot(t,p(:,3),'r',t,p(:,4),'b:','linewidth',2);
xlabel('time(s)');ylabel('d and its estimate');
legend('d','Estimate d');

figure(2);
plot(t,sin(t),'r',t,p(:,1),'b:','linewidth',2);
xlabel('time(s)');ylabel('Ideal position signal and position tracking');
legend('Ideal position signal','position tracking');