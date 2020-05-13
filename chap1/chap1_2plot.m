close all;

plot(t,yd(:,1),'r',t,y(:,1),'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');