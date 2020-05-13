function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 5;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[0 0 0];
str=[];
ts=[-1 0];
function sys=mdlDerivatives(t,x,u)
th=u(1);
dth=u(2);
r=u(3);
thm=u(4);
dthm=u(5);
b1=20;b2=30;b=50;
Am=[0,1;-b2,-b1];
eig(Am);
%Q=[10 0;0,10];
Q=[20,10;10,20];
P=lyap(Am',Q);
p12=P(1,2);
p22=P(2,2);

e=thm-th;
de=dthm-dth;
eF=p12*e+p22*de;

sys(1)=30*eF*r;      %k0
sys(2)=30*eF*th;     %k1
sys(3)=30*eF*dth;    %k2
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);