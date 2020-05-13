close all;

figure(1);
subplot(211);
plot(t,y(:,1),'r',t,y(:,2),'k-.','linewidth',2);
xlabel('time(s)');ylabel('yd and y'); 
legend('ideal position signal', 'tracking signal');
subplot(212);
plot(t,y(:,1)-y(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('position tracking error'); 
legend('ideal position signal', 'tracking signal');

figure(2);
subplot(211);
plot(t,x(:,1),'r',t,x(:,4),'k','linewidth',2);
xlabel('time(s)');ylabel('th and x1p'); 
subplot(212);
plot(t,x(:,2),'r',t,x(:,5),'k','linewidth',2);
xlabel('time(s)');ylabel('dth and x2p');
figure(3);
plot(t,x(:,3),'r',t,x(:,6),'k','linewidth',2);
xlabel('time(s)');ylabel('f and fp');