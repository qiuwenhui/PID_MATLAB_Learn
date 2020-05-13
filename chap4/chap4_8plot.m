close all;

figure(1);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('ideal position signal','position tracking');

figure(2);
subplot(211);
plot(t,s(:,1),'k',t,s(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('sigal');
legend('position signal with noise','position signal with TD');
subplot(212);
plot(t,y(:,3),'r',t,s(:,3),'k:','linewidth',2);
xlabel('time(s)');ylabel('sigal');
legend('practical deritive signal','deritive signal with TD');

figure(3);
plot(t,n(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('sigal');