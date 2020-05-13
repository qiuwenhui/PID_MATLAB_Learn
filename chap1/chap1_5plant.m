function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1; % At least one sample time is needed
sys = simsizes(sizes);
x0  = [0;0];
str = [];
ts  = [0 0];
function sys=mdlDerivatives(t,x,u)   %Time-varying model
ut=u(1);
J=20+10*sin(6*pi*t);
K=400+300*sin(2*pi*t);
sys(1)=x(2);
sys(2)=-J*x(2)+K*ut;
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);