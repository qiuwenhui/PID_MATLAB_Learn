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
sizes.NumContStates  = 6;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;
sizes.NumInputs      =2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[0 0 1 0 0 0];
str=[];
ts=[-1 0];
function sys=mdlDerivatives(t,x,u)
th=x(5);
g=9.8;

sys(1)=x(2);
sys(2)=-u(1)*sin(th);
sys(3)=x(4);
sys(4)=u(1)*cos(th)-g;
sys(5)=x(6);
sys(6)=u(2);
function sys=mdlOutputs(t,x,u)
x1=x(1);x2=x(2);
y1=x(3);y2=x(4);
th=x(5);dth=x(6);

sys(1)=x1;
sys(2)=x2;
sys(3)=y1;
sys(4)=y2;
sys(5)=th;
sys(6)=dth;