function [sys,x0,str,ts] = spacemodel(t,x,u,flag)

switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 6;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];

function sys=mdlOutputs(t,x,u)
R1=u(1);dr1=0;
R2=u(2);dr2=0;

x(1)=u(3);
x(2)=u(4);
x(3)=u(5);
x(4)=u(6);

e1=R1-x(1);
e2=R2-x(3);
e=[e1;e2];

de1=dr1-x(2);
de2=dr2-x(4);
de=[de1;de2];

Kp=[50 0;0 50];
Kd=[50 0;0 50];

tol=Kp*e+Kd*de;

sys(1)=tol(1);
sys(2)=tol(2);