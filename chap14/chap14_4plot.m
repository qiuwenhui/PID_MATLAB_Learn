close all;

figure(1);
plot(xd(:,1),xd(:,2),'r','linewidth',2);
hold on;
plot(x(:,1),x(:,2),'b--','linewidth',1);
xlabel('x');ylabel('y');
legend('ideal trajectory','position tracking');

figure(2);
subplot(311);
plot(t,xd(:,1),'r',t,x(:,1),'b--','linewidth',2);
xlabel('time(s)');ylabel('x tracking');
legend('ideal x','x tracking');
subplot(312);
plot(t,xd(:,2),'r',t,x(:,2),'b--','linewidth',2);
xlabel('time(s)');ylabel('y tracking');
legend('ideal y','y tracking');
subplot(313);
plot(t,thd(:,1),'r',t,x(:,3),'b--','linewidth',2);
xlabel('time(s)');ylabel('\theta_d tracking');
legend('\theta_d','\theta_d tracking');

figure(3);
plot(t,thd(:,1),'r',t,dthd(:,1),'b--','linewidth',2);
xlabel('time(s)');ylabel('\theta_d, d\theta_d');
legend('\theta_d','d\theta_d');

figure(4);
subplot(211);
plot(t,ut(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input v');
subplot(212);
plot(t,ut(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input w');

max_thd=max(thd)   %must be in [-pi/2,pi/2]