close all;

figure(1);
subplot(211);
plot(t,xd(:,1),'r--',t,x(:,1),'b','linewidth',2);
xlabel('time(s)');ylabel('position tracking of x1 axis');
legend('ideal xd1','practical x1');
subplot(212);
plot(t,xd(:,4),'r',t,x(:,4),'b--','linewidth',2);
xlabel('time(s)');ylabel('position tracking of x2 axis');
legend('ideal xd2','practical x2');

figure(2);
plot(t,x(:,7),'r',t,x(:,8),'b--','linewidth',2);
xlabel('time(s)');ylabel('Fe1 and Fe2');
legend('External force of Fe1','External force of Fe2');

figure(3);
plot(t,x(:,9),'r',t,x(:,10),'b--','linewidth',2);
xlabel('time(s)');ylabel('Conrol input tol1 and tol2');
legend('tol of first link','tol of second link');

figure(4);
plot(xc(:,1),xc(:,4),'r','linewidth',2);
hold on;
plot(x(:,1),x(:,4),'b--','linewidth',1);
xlabel('x1');ylabel('x2');
legend('ideal xc trajectory','practical  trajectory');

figure(5);
plot(t,xd(:,1),'r',t,xd(:,4),'b--','linewidth',2);
xlabel('time(s)');ylabel('xd');
legend('xd1','xd2');