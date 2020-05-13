function [sys,x0,str,ts]=chap14_5plant(t,x,u,flag)
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
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[0 0 0 0 0 0];
str=[];
ts=[-1 0];
function sys=mdlDerivatives(t,x,u)
u2=u(1);u3=u(2);u4=u(3);

chap15_2int;

theta=x(1);dtheta=x(2);
psi=x(3);dpsi=x(4);
phi=x(5);dphi=x(6);

ddtheta=u2-l*K4*dtheta/I1;
ddpsi=u3-l*K5*dpsi/I2;
ddphi=u4-K6*dphi/I3;

sys(1)=x(2);
sys(2)=ddtheta;
sys(3)=x(4);
sys(4)=ddpsi;
sys(5)=x(6);
sys(6)=ddphi;
function sys=mdlOutputs(t,x,u)
theta=x(1);dtheta=x(2);
psi=x(3);dpsi=x(4);
phi=x(5);dphi=x(6);

sys(1)=theta;
sys(2)=dtheta;
sys(3)=psi;
sys(4)=dpsi;
sys(5)=phi;
sys(6)=dphi;