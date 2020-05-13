close all;
figure(1);
plot(t,y(:,1),'r',t,y(:,2),'k','linewidth',2);
xlabel('time');ylabel('Step response');

if M==1
    title('M=1:Kp=10,Kd=10');
elseif M==2
    title('M=2:Kp=10,Kd=20');
elseif M==3
    title('M=3:Kp=20,Kd=10');
end