close all;

figure(1);
subplot(211);
plot(t,x1(:,1),'r',t,x1(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('position tracking of link 1');
subplot(212);
plot(t,x2(:,1),'r',t,x2(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('position tracking of link 2');

figure(2);
subplot(211);
plot(t,tol(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('tol1');
subplot(212);
plot(t,tol(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('tol2');