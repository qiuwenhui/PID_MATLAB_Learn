close all;

figure(1);
subplot(211);
plot(t,xd(:,1),'r',t,x(:,1),'b--','linewidth',2);
xlabel('time(s)');ylabel('position tracking of x axis');
legend('ideal x','practical x');
subplot(212);
plot(t,xd(:,4),'r',t,x(:,3),'b--','linewidth',2);
xlabel('time(s)');ylabel('position tracking of y axis');
legend('ideal y','practical y');

figure(2);
subplot(211);
plot(t,xd(:,2),'r',t,x(:,2),'b--','linewidth',2);
xlabel('time(s)');ylabel('velocity tracking of x axis');
legend('ideal dx','practical dx');
subplot(212);
plot(t,xd(:,5),'r',t,x(:,4),'b--','linewidth',2);
xlabel('time(s)');ylabel('velocity tracking of y axis');
legend('ideal dy','practical dy');

figure(3);
subplot(211);
plot(t,x(:,5),'r',t,x(:,6),'b--','linewidth',2);
xlabel('time(s)');ylabel('Conrol input Fx1 and Fx2');
legend('Fx of first link','Fx of second link');
subplot(212);
plot(t,x(:,7),'r',t,x(:,8),'b--','linewidth',2);
xlabel('time(s)');ylabel('Conrol input tol1 and tol2');
legend('tol of first link','tol of second link');

figure(4);
plot(xd(:,1),xd(:,4),'r','linewidth',2);
hold on;
plot(x(:,1),x(:,3),'b--','linewidth',1);
xlabel('x');ylabel('y');
legend('ideal trajectory','practical  trajectory');