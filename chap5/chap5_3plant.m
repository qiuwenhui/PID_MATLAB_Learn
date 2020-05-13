function [sys,x0,str,ts]= NDO_plant (t,x,u,flag)
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
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0.1,0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
ut=u(1);
%dt=-5;
dt=0.05*sin(t);
sys(1)=x(2);
sys(2)=-25*x(2)+133*(ut+dt);
function sys=mdlOutputs(t,x,u)
%dt=-5;
dt=0.05*sin(t);
sys(1)=x(1);
sys(2)=x(2);
sys(3)=dt;