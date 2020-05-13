close all;

figure(1);
plot(t,p(:,3),'r',t,p(:,4),'b:','linewidth',2);
xlabel('time(s)');ylabel('d and its estimate');
legend('d','Estimate d');