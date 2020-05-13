close all;

figure(1);
subplot(211);
plot(t,x(:,1),'r',t,x(:,5),'b:','linewidth',2);
xlabel('time(s)');ylabel('position tracking for link 1');
legend('Ideal position signal','Position signal tracking');
subplot(212);
plot(t,x(:,2),'r',t,x(:,6),'b:','linewidth',2);
xlabel('time(s)');ylabel('speed tracking for link 1');
legend('Ideal speed signal','Speed signal tracking');

figure(2);
subplot(211);
plot(t,x(:,3),'r',t,x(:,7),'b:','linewidth',2);
xlabel('time(s)');ylabel('position tracking for link 1');
legend('Ideal position signal','Position signal tracking');
subplot(212);
plot(t,x(:,4),'r',t,x(:,8),'b:','linewidth',2);
xlabel('time(s)');ylabel('speed tracking for link 1');
legend('Ideal speed signal','Speed signal tracking');

figure(3);
subplot(211);
plot(t,tol1(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('control input of link 1');
subplot(212);
plot(t,tol2(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('control input of link 2');