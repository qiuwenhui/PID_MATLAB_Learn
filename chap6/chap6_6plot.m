close all;

figure(1);
subplot(211);
plot(t,x(:,1),'r',t,x(:,4),'k:','linewidth',2);
xlabel('time(s)');ylabel('th and x1p'); 
legend('practical position signal', 'position signal estimation');
subplot(212);
plot(t,x(:,2),'r',t,x(:,5),'k:','linewidth',2);
xlabel('time(s)');ylabel('dth and x2p');
legend('practical speed signal', 'speed signal estimation');
figure(2);
plot(t,x(:,3),'r',t,x(:,6),'k:','linewidth',2);
xlabel('time(s)');ylabel('f and fp');
legend('practical unceratin part', 'unceratin part estimation');