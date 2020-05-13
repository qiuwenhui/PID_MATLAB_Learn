close all;
figure(1);
plot(t,y(:,1),'k',t,y(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('thd and y');
legend('ideal position signal','delayed position signal');

figure(2);
subplot(211);
plot(t,y1(:,1),'k',t,y1(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('x1 and its estimate');
legend('ideal signal x1','estimation signal x1');
subplot(212);
plot(t,y1(:,2),'k',t,y1(:,4),'r:','linewidth',2);
xlabel('time(s)');ylabel('x2 and its estimate');
legend('ideal signal x2','estimation signal x2');

figure(3);
subplot(211);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('thd and y');
legend('ideal position signal','position tracking signal');
subplot(212);
plot(t,cos(t),'k',t,y(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('dthd and dy');
legend('ideal speed signal','speed tracking signal');

figure(4);
plot(t,ut(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('Control input');