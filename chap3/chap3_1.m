%Series System Control
clear all;
close all;

ts=2;
sys1=tf(1,[10,1]);
dsys1=c2d(sys1,ts,'z');
[num1,den1]=tfdata(dsys1,'v');

sys2=tf(1,[10,1]);
dsys2=c2d(sys2,ts,'z');
[num2,den2]=tfdata(dsys2,'v');

dph=1/zpk('z',ts);
Gc2=dph/(dsys2*(1-dph));
[nump,denp]=tfdata(Gc2,'v');

u1_1=0.0;u2_1=0.0;
y1_1=0;y2_1=0;
e2_1=0;ei=0;

for k=1:1:2000
time(k)=k*ts;

R1(k)=1;                            
%Linear model
y1(k)=-den1(2)*y1_1+num1(2)*y2_1;  %Main plant

y2(k)=-den2(2)*y2_1+num2(2)*u2_1;  %Assistant plant

error(k)=R1(k)-y1(k);
ei=ei+error(k);
u1(k)=1.2*error(k)+0.02*ei;   %Main Controller

e2(k)=u1(k)-y2(k);            %Assistant Controller
u2(k)=-denp(2)*u2_1+nump(1)*e2(k)+nump(2)*e2_1;

d2(k)=0.01*rands(1);
u2(k)=u2(k)+d2(k);

%----------Return of PID parameters------------
u1_1=u1(k);
u2_1=u2(k);

e2_1=e2(k);

y1_1=y1(k);
y2_1=y2(k);
end
figure(1);     %Assistant Control
plot(time,u1,'k',time,y2,'r:','linewidth',2);
xlabel('time(s)');ylabel('u1,y2');
legend('u1','y2');

figure(2);     %Main Control
plot(time,R1,'k',time,y1,'r:','linewidth',2);
xlabel('time(s)');ylabel('R1,y1');
legend('R1','y1');

figure(3);
plot(time,d2,'r');
xlabel('time(s)');ylabel('disturbance');