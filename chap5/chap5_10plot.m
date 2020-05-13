close all;

figure(1);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('th and x1p'); 
legend('Ideal position','Position tracking');

figure(2);
subplot(211);
plot(t,x(:,1),'k',t,x(:,4),'r:','linewidth',2);
xlabel('time(s)');ylabel('th and x1p'); 
legend('practical position','position estimation');
subplot(212);
plot(t,x(:,2),'k',t,x(:,5),'r:','linewidth',2);
xlabel('time(s)');ylabel('dth and x2p');
legend('practical speed','speed estimation');

figure(3);
plot(t,x(:,3),'k',t,x(:,6),'r:','linewidth',2);
xlabel('time(s)');ylabel('f and fp');
legend('practical uncertain part','uncertain part estimation');

figure(4);
plot(t,ut(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');