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
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 0;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[0 0];
str=[];
ts=[-1 0];
function sys=mdlDerivatives(t,x,u)
r=1.0*sign(sin(0.05*t*2*pi)); 
a0=30;a1=20;b=50;

sys(1)=x(2);
sys(2)=b*r-a1*x(2)-a0*x(1);
function sys=mdlOutputs(t,x,u)
r=1.0*sign(sin(0.05*t*2*pi)); 
sys(1)=r;
sys(2)=x(1);
sys(3)=x(2);