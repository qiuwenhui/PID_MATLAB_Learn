close all;
figure(1);
subplot(211);
plot(t,x(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('Angle response of link');
subplot(212);
plot(t,x(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('Position response of cart');

figure(2);
subplot(211);
plot(t,x(:,3),'k','linewidth',2);
xlabel('time(s)');ylabel('Angle speed response of link');
subplot(212);
plot(t,x(:,4),'k','linewidth',2);
xlabel('time(s)');ylabel('Position speed response of cart');

figure(3);
plot(t,ut,'k','linewidth',2);
xlabel('time(s)');ylabel('Control input');