close all;

figure(1);
subplot(211);
plot(t,y(:,1),'r',t,y(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('Ideal position','Position tracking');
subplot(212);
plot(t,0.1*cos(t),'r',t,y(:,3),'k:','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking');
legend('Ideal speed','Speed tracking');

figure(2);
plot(t,u(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');

figure(3);
plot(t,fx(:,1),'r',t,fx(:,2),'k:','linewidth',2);;
xlabel('time(s)');ylabel('fx and estiamted fx');
legend('practical fx','fx estimation');