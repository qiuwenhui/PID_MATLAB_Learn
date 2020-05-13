close all;

figure(1);
subplot(211);
plot(t,d(:,3),'r',t,dp(:,1),'-.b','linewidth',2);
xlabel('time(s)');ylabel('dt and its estimation');
legend('dt','dt estiamtion');
subplot(212);
plot(t,d(:,3)-dp(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('error between dt and its estimation');