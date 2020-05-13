close all;

figure(1);
subplot(211);
plot(t,y(:,2),'r',t,y(:,4),'b:','linewidth',2);
xlabel('time(s)');ylabel('position tracking');
legend('Ideal position signal','Position signal tracking');
subplot(212);
plot(t,y(:,3),'r',t,y(:,5),'b:','linewidth',2);
xlabel('time(s)');ylabel('speed tracking');
legend('Ideal speed signal','Speed signal tracking');

figure(2);
subplot(311);
plot(t,k(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('k0');
subplot(312);
plot(t,k(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('k1');
subplot(313);
plot(t,k(:,3),'r','linewidth',2);
xlabel('time(s)');ylabel('k2');