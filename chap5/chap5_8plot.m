close all;

figure(1);
plot(t,x(:,1),'k',t,x(:,4),'r:','linewidth',2);
xlabel('time(s)');ylabel('x1 and x1 estimation');
legend('angle practical value','angle estimation');

figure(2);
plot(t,x(:,2),'k',t,x(:,5),'r:','linewidth',2);
xlabel('time(s)');ylabel('x2 and x2 estimation');
legend('angle speed practical value','angle speed estimation');

figure(3);
plot(t,x(:,3),'k',t,x(:,6),'r:','linewidth',2);
xlabel('time(s)');ylabel('x3 and x3 estimation');
legend('fx practical value','fx estimation');