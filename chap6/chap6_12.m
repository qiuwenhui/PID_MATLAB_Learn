clear all;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=0.01;  %Sampling time
%Transient Parameters with TD
delta=10;
%ESO Parameters
beta1=100;beta2=200;beta3=500;
delta1=0.0025;
alfa1=0.5;alfa2=0.25;
%NPID Parameters
delta0=2*h;
alfa01=3/4;alfa02=3/2;   %0<alfa1<1<alfa2
beta01=10;beta02=0.3;
kp=beta01;kd=beta02;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xk=zeros(2,1);
e1_1=0;
u_1=0;
v_1=0;
v1_1=0;v2_1=0;
z1_1=0;z2_1=0;z3_1=0;
for k=1:1:2000
time(k) = k*h;

p1=u_1;
p2=k*h;
tSpan=[0 h];
[tt,xx]=ode45('chap6_12plant',tSpan,xk,[],p1,p2);
xk = xx(length(xx),:);
y(k)=xk(1);
dy(k)=xk(2);

v(k)=sign(sin(k*h));
dv(k)=0;

f(k)=-25*dy(k)+33*sin(pi*p2);    %Uunknown part
b=133;
x3(k)=f(k);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TD Transient
x1=v1_1-v_1;
x2=v2_1;

v1(k)=v1_1+h*v2_1;
v2(k)=v2_1+h*fst(x1,x2,delta,h);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ESO
e=z1_1-y(k);
z1(k)=z1_1+h*(z2_1-beta1*e);
z2(k)=z2_1+h*(z3_1-beta2*fal(e,alfa1,delta1)+b*u_1);
z3(k)=z3_1-h*beta3*fal(e,alfa2,delta1);

z1_1=z1(k);
z2_1=z2(k);
z3_1=z3(k);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%N-PD and disturbance compensation
e1(k)=v1(k)-z1(k);
e2(k)=v2(k)-z2(k);

M=2;
if M==1            %ADRC
    u0(k)=kp*fal(e1(k),alfa01,delta0)+kd*fal(e2(k),alfa02,delta0);
    u(k)=u0(k)-z3(k)/b;
elseif M==2        % Ordinary PD
    u(k)=kp*(v(k)-y(k))+kd*(dv(k)-dy(k));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v_1=v(k);
v1_1=v1(k);
v2_1=v2(k);

z1_1=z1(k);z2_1=z2(k);z3_1=z3(k);
u_1=u(k);
end

if M==1
    figure(1);
    plot(time,v,'r',time,v1,'k:',time,y,'b-.','linewidth',2);
    xlabel('time(s)'),ylabel('position signal');
    legend('ideal position signal', 'transient position signal','position tracking signal');
    figure(2);
    subplot(311);
    plot(time,z1,'r',time,y,'k:','linewidth',2);
    xlabel('time(s)'),ylabel('z1,y');
    legend('practical position signal', 'position signal estimation');    
    subplot(312);
    plot(time,z2,'r',time,dy,'k:','linewidth',2);
    xlabel('time(s)'),ylabel('z2,dy');
    legend('practical speed signal', 'speed signal estimation');    
    subplot(313);
    plot(time,z3,'r',time,x3,'k:','linewidth',2);
    xlabel('time(s)'),ylabel('z3,x3');
    legend('practical uncertain part', 'uncertain part estimation'); 
elseif M==2
    figure(1);
    plot(time,v,'r',time,y,'k:','linewidth',2);
    xlabel('time(s)'),ylabel('position signal');
    legend('ideal position signal','position tracking');
end