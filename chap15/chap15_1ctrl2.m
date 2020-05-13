function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
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
sizes.NumInputs      = 9;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[0 0];
function sys=mdlOutputs(t,x,u)
g=9.8;

x1=u(1);x2=u(2);
y1=u(3);y2=u(4);
th=u(5);dth=u(6);
thd=u(7);
dthd=u(8);
ddthd=u(9);

e=th-thd;
de=dth-dthd;

kp=25;kd=10;
u2=-kp*e-kd*de+ddthd;

sys(1)=u2;