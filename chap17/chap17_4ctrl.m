function [sys,x0,str,ts]=obser(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {1, 2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 6;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[];
function sys=mdlOutputs(t,x,u)
yd=u(1);
dyd=cos(t);
ddyd=-sin(t);
e=u(2);
de=u(3);
x1=u(4);
x2=u(5);
x3=u(6);

f=(x1^5+x3)*(x3+cos(x2))+(x2+1)*x1^2;

M=2;
if M==1
    k1=10;k2=10;
    v=ddyd+k1*e+k2*de;
    ut=1.0/(x2+1)*(v-f);
elseif M==2
    ut=150*e+30*de;  %PD
end
sys(1)=ut;