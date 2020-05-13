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
sizes.NumContStates  = 1;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
xd=u(1);
dxd=cos(t);
ddxd=-sin(t);
x1=u(2);
x2=u(3);

e=x1-xd;
de=x2-dxd;

c=15;
gama=500;

s=de+c*e;
thp=x(1);
dq=ddxd-c*de;

th_min=0.5;
th_max=1.5;

alaw=-gama*dq*s;   %Adaptive law

N=2;
if N==1
    sys(1)=alaw;
elseif N==2
    if thp>=th_max&alaw>0
        sys(1)=0;
    elseif thp<=th_min&alaw<0
        sys(1)=0;
    else
    sys(1)=alaw;
    end
end
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);       %J estimate