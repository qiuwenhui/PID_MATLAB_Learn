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
x0=[0 0 0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
y=u(1);
ut=u(2);

J=10;
b=1/J;

alfa1=6;alfa2=11;alfa3=6;

M=2;
if M==1
    epc=0.01;
elseif M==2
    if t<=1;
        R=100*t^3;
    elseif t>1;
        R=100;
    end
    epc=1/R;
elseif M==3
    nmn=0.1;
    R=100*(1-exp(-nmn*t))/(1+exp(-nmn*t));
    epc=1/R;
end

e=y-x(1);
sys(1)=x(2)+alfa1/epc*e;
sys(2)=b*ut+x(3)+alfa2/epc^2*e;
sys(3)=alfa3/epc^3*e;
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);