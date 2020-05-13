close all;
figure(1);
subplot(211);
plot(t,x(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Pendulum Angle response');
subplot(212);
plot(t,x(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('Pendulum Angle speed response');

figure(2);
subplot(211);
plot(t,x(:,3),'r','linewidth',2);
xlabel('time(s)');ylabel('Cart position response');
subplot(212);
plot(t,x(:,4),'r','linewidth',2);
xlabel('time(s)');ylabel('Cart speed response');

figure(3);
plot(t,ut,'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');