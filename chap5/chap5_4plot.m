close all;
figure(1);
subplot(211);
plot(t,sin(t),'r',t,x(:,1),'-.b','linewidth',2);
xlabel('time(s)');ylabel('x1 tracking');
legend('ideal angle','x1');
subplot(212);
plot(t,cos(t),'r',t,x(:,2),'-.b','linewidth',2);
xlabel('time(s)');ylabel('x2 tracking');
legend('ideal angle speed','x2');

figure(2);
subplot(211);
plot(t,x(:,3),'r',t,dp(:,1),'-.b','linewidth',2);
xlabel('time(s)');ylabel('dt and its estimation');
legend('dt','dt estiamtion');
subplot(212);
plot(t,x(:,3)-dp(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('error between dt and its estimation');

figure(3);
plot(t,ut(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');