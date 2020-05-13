clear all;
close all;
Ts=20;

%Delay plant
deltar=0.575;
Tr=1000/4;   %From 4000 to 5000

kp=1;
Tp=60;
tol=80;
sys=tf([kp],[Tp,1],'inputdelay',tol);
dsys=c2d(sys,Ts,'zoh');
[num,den]=tfdata(dsys,'v');

u_1=0.0;u_2=0.0;u_3=0.0;u_4=0.0;u_5=0.0;
e_1=0;
ei=0;
y_1=0.0;
for k=1:1:300
    time(k)=k*Ts;
   
yd(k)=1.0;     %Tracing Step Signal

y(k)=-den(2)*y_1+num(2)*u_5;

e(k)=yd(k)-y(k);
de(k)=(e(k)-e_1)/Ts;
ei=ei+Ts*e(k);

u(k)=1/deltar*e(k);   

M=1;
if M==1   %Critical testing
    delta=deltar;
    u(k)=1/delta*e(k);   
elseif M==2         %P
    delta1=2*deltar;
    u(k)=1/delta1*e(k);   
elseif M==3        %PI
    delta2=2.2*deltar;    
    TI2=0.85*Tr;
    u(k)=1/delta2*(e(k)+1/TI2*ei);   
elseif M==4        %PID
    delta3=1.7*deltar;    
    TI3=0.5*Tr;
    TD3=0.13*Tr;    
    u(k)=1/delta3*(e(k)+1/TI3*ei+TD3*de(k));   
end
e_1=e(k);
u_5=u_4;u_4=u_3;u_3=u_2;u_2=u_1;u_1=u(k);
y_1=y(k);
end
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('Ideal position signal','position tracking','location','NorthEast');