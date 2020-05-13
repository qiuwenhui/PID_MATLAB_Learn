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
sizes.NumInputs      = 12;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  =[];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
chap15_2int;

x1=u(1);dx1=u(2);
y=u(3);dy=u(4);
z=u(5);dz=u(6);
phi=u(11);

dzd=0;ddzd=0;
ze=z-zd;
dze=dz-dzd;

kdx=5;kpx=5;
kdy=5;kpy=5;
kdz=5;kpz=5;
u1x=-kpx*x1-kdx*dx1;
u1y=-kpy*y-kdy*dy;
u1z=-kpz*ze-kdz*dze+g+ddzd+K3/m*dzd;

X=(cos(phi)*cos(phi)*u1x+cos(phi)*sin(phi)*u1y)/u1z;
%To Gurantee X is [-1,1]
if X>1 
    sin_thetad=1;
    thetad=pi/2;
elseif X<-1
    sin_thetad=-1;
    thetad=-pi/2;
else
    sin_thetad=X;
    thetad=asin(X);
end
psid=atan((sin(phi)*cos(phi)*u1x-cos(phi)*cos(phi)*u1y)/u1z);

u1=u1z/(cos(phi)*cos(psid));
sys(1)=u1; 
sys(2)=thetad;
sys(3)=psid;