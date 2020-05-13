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
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 14;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
chap15_2int;

dphid=0;ddphid=0;
thetad=u(1);
psid=u(2);
dthetad=u(4);
ddthetad=u(5);
dpsid=u(7);
ddpsid=u(8);

theta=u(9);dtheta=u(10);
psi=u(11);dpsi=u(12);
phi=u(13);dphi=u(14);

thetae=theta-thetad;dthetae=dtheta-dthetad;
psie=psi-psid;dpsie=dpsi-dpsid;
phie=phi-phid;dphie=dphi-dphid;

kp4=15;kd4=15;
kp5=15;kd5=15;
kp6=15;kd6=15;

u2=-kp4*thetae-kd4*dthetae+ddthetad+l*K4/I1*dthetad;
u3=-kp5*psie-kd5*dpsie+ddpsid+l*K5/I2*dpsid;
u4=-kp6*phie-kd6*dphie+ddphid+l*K6/I3*dphid;

sys(1)=u2;
sys(2)=u3;
sys(3)=u4;