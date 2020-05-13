close all;
figure(1);
subplot(211);
plot(t,y(:,1),'r',t,y(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('step response');
legend('ideal position signal','position tracking');
subplot(212);
plot(t,y(:,1)-y(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('position tracking error');

figure(2);
plot(t,ut(:,1),'r',t,ut(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('control input');
legend('before saturation','after saturation');