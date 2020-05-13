close all;

figure(1);
subplot(211);
plot(t,sin(t),'r',t,r,'k:','linewidth',2);
xlabel('time(s)');ylabel('sigal');
legend('ideal signal','signal with noise');
subplot(212);
plot(t,sin(t),'r',t,y(:,1),'k:','linewidth',2);
xlabel('time(s)');ylabel('sigal');
legend('ideal signal','signal by TD');

figure(2);
plot(t,cos(t),'r',t,y(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('derivative signal');
legend('ideal derivative signal','derivative signal by TD');