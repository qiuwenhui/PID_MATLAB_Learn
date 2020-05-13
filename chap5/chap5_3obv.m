function [sys,x0,str,ts]= NDO(t,x,u,flag)
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
K=50;
J=1/133;
b=25/133;

ut=u(1);

dth=u(3);
z=x(1);
dp=z+K*J*dth;

dz=K*(b*dth-ut)-K*dp;
sys(1)=dz;
function sys=mdlOutputs(t,x,u)
K=50;
J=1/133;
dth=u(3);
z=x(1);
dp=z+K*J*dth;

sys(1)=dp;