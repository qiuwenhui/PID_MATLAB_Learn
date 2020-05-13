close all;

figure(1);
plot(t,x(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('x response');

figure(2);
subplot(311);
plot(t,ut(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('us');
legend('Control input for slow subsystem');
subplot(312);
plot(t,ut(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('uf');
legend('Control input for fast subsystem');
subplot(313);
plot(t,ut,'k','linewidth',2);
xlabel('time(s)');ylabel('ut');
legend('Total control input');