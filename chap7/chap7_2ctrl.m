function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {1,2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[0 0];
function sys=mdlOutputs(t,x,u)
xd=u(1);
dxd=cos(t);
ddxd=-sin(t);

x1=u(2);
x2=u(3);
e=xd-x1;
de=dxd-x2;

 
kp=100;ki=30;
c=5.0;
s=c*e+de;
dxr=dxd+c*e;
ddxr=ddxd+c*de;

J=10;C=5;
um=J*ddxr+C*dxr;
kr=30.5;
ur=kr*sign(s);
I=u(4);
ut=um+kp*s+ki*I+ur;

sys(1)=ut;