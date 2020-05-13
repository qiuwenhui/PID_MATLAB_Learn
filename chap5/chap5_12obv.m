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
sizes.NumOutputs     = 2;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[0 0];
str=[];
ts=[-1 0];
function sys=mdlDerivatives(t,x,u)
tol=3;
th_tol=u(1);
yp=th_tol;

ut=u(2);

z_tol=[u(3);u(4)];

thp=x(1);wp=x(2);
%%%%%%%%%%%%%%%%%%%
A=[0 1;-1 -10];
C=[1 0];

H=[0;1];

k1=0.1;k2=0.1;  %Verify by design_K.m
z=[thp wp]';
%%%%%%%%%%%%%%%%%%
K=[k1 k2]';

dz=A*z+H*ut+K*(yp-C*z_tol);

for i=1:2
    sys(i)=dz(i);

end
function sys=mdlOutputs(t,x,u)
thp=x(1);wp=x(2);

sys(1)=thp;
sys(2)=wp;
