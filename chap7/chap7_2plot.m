close all;

figure(1);
subplot(211);
plot(t,x(:,1),'r',t,x(:,2),'b:','linewidth',2);
xlabel('time(s)');ylabel('position tracking');
legend('Ideal position signal','Position signal tracking');
subplot(212);
plot(t,cos(t),'r',t,x(:,3),'b:','linewidth',2);
xlabel('time(s)');ylabel('speed tracking');
legend('Ideal speed signal','Speed signal tracking');

figure(2);
plot(t,ut(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('control input');