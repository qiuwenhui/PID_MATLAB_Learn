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
sizes.NumContStates  = 4;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 8;
sizes.NumInputs      = 16;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0.8 0 1.0 0.2*pi];   %xd(0)=xc(0),dxd(0)=dxc(0)
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
xc=[1.0-0.2*cos(pi*t) 1.0+0.2*sin(pi*t)]';
dxc=[0.2*pi*sin(pi*t) 0.2*pi*cos(pi*t)]';
ddxc=[0.2*pi^2*cos(pi*t) -0.2*pi^2*sin(pi*t)]';

Mm=[1 0;0 1];
Bm=[10 0;0 10];
Km=[50 0;0 50];

x1=u(7);dx1=u(8);ddx1=u(9);
x2=u(10);dx2=u(11);ddx2=u(12);

xp=[x1 x2]';
dxp=[dx1 dx2]';
ddxp=[ddx1 ddx2]';

if x1>=1.0
   xp=[1.0 xp(2)]';dxp=[0 dxp(2)]';ddxp=[0 ddxp(2)]';
end
  
Fe=Mm*(ddxc-ddxp)+Bm*(dxc-dxp)+Km*(xc-xp);
if x1<=1.0
   Fe=[0 0]';
end

xd=[x(1);x(3)];
dxd=[x(2);x(4)];
ddxd=inv(Mm)*((-Fe+Mm*ddxc+Bm*dxc+Km*xc)-Bm*dxd-Km*xd);

sys(1)=x(2);
sys(2)=ddxd(1);
sys(3)=x(4);
sys(4)=ddxd(2);

function sys=mdlOutputs(t,x,u)
xc=[1.0-0.2*cos(pi*t) 1.0+0.2*sin(pi*t)]';
dxc=[0.2*pi*sin(pi*t) 0.2*pi*cos(pi*t)]';
ddxc=[0.2*pi^2*cos(pi*t) -0.2*pi^2*sin(pi*t)]';

Mm=[1 0;0 1];
Bm=[10 0;0 10];
Km=[40 0;0 40];

x1=u(7);dx1=u(8);ddx1=u(9);
x2=u(10);dx2=u(11);ddx2=u(12);

xp=[x1 x2]';
dxp=[dx1 dx2]';
ddxp=[ddx1 ddx2]';


if x1>=1.0
   xp=[1.0 xp(2)]';dxp=[0 dxp(2)]';ddxp=[0 ddxp(2)]';
end

Fe=Mm*(ddxc-ddxp)+Bm*(dxc-dxp)+Km*(xc-xp);
if x1<=1.0
   Fe=[0 0]';
end

xd=[x(1);x(3)];
dxd=[x(2);x(4)];
S=inv(Mm)*((-Fe+Mm*ddxc+Bm*dxc+Km*xc)-Bm*dxd-Km*xd);   %ddxd

sys(1)=x(1);
sys(2)=x(2);
sys(3)=S(1);
sys(4)=x(3);
sys(5)=x(4);
sys(6)=S(2);
sys(7)=Fe(1);
sys(8)=Fe(2);