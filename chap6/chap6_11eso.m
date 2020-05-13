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
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0;0;0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
%ESO Parameters
beta1=100;beta2=300;beta3=1000;
delta1=0.0025;
alfa1=0.5;alfa2=0.25;
x1=u(1);
ut=u(2);
e=x(1)-x1;

if abs(e)>delta1
   fal1=abs(e)^alfa1*sign(e);
else
   fal1=e/(delta1^(1-alfa1));
end
if abs(e)>delta1
   fal2=abs(e)^alfa2*sign(e);
else
   fal2=e/(delta1^(1-alfa2));
end

b=133;
sys(1)=x(2)-beta1*e;
sys(2)=x(3)-beta2*fal1+b*ut;
sys(3)=-beta3*fal2;
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);