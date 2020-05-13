close all;

figure(1);
subplot(211);
plot(t,sin(t),'k',t,p(:,1),'r:','linewidth',2);
xlabel('time(s)');ylabel('x1 tracking');
legend('ideal x1','practical x1');
subplot(212);
plot(t,cos(t),'k',t,p(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('x2 tracking');
legend('ideal x2','practical x2');

figure(2);
subplot(211);
plot(t,cos(t),'k',t,p(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('y1 tracking');
legend('ideal y1','practical y1');
subplot(212);
plot(t,-sin(t),'k',t,p(:,4),'r:','linewidth',2);
xlabel('time(s)');ylabel('y2 tracking');
legend('ideal y2','practical y2');

figure(3);
subplot(211);
plot(t,thd(:,1),'k',t,p(:,5),'r:','linewidth',2);
xlabel('time(s)');ylabel('th tracking');
legend('given thd','practical th');
subplot(212);
plot(t,dthd(:,1),'k',t,p(:,6),'r:','linewidth',2);
xlabel('time(s)');ylabel('w tracking');
legend('given dthd','practical dthd');

figure(4);
subplot(211);
plot(t,ut(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('control input u1');
subplot(212);
plot(t,ut(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('control input u2');

figure(5);
plot(sin(t),cos(t),'r','linewidth',2);
hold on;
plot(p(:,1),p(:,3),'-.k','linewidth',2);
xlabel('time(s)');ylabel('trajectory of XY');
legend('ideal trajectory','practical trajectory');