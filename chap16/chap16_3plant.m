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
sizes.NumContStates  = 4;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1; % At least one sample time is needed
sys = simsizes(sizes);
x0  = [-30/57.3,0,0.20/57.3,0];   %Initial state
str = [];
ts  = [0 0];
function sys=mdlDerivatives(t,x,u)   %Time-varying model
%Single Link Inverted Pendulum Parameters
g=9.8;M=1.0;m=0.1;L=0.5;
I=1/12*m*L^2;  
l=1/2*L;
t1=m*(M+m)*g*l/[(M+m)*I+M*m*l^2];
t2=-m^2*g*l^2/[(m+M)*I+M*m*l^2];
t3=-m*l/[(M+m)*I+M*m*l^2];
t4=(I+m*l^2)/[(m+M)*I+M*m*l^2];

A=[0,0,1,0;
   0,0,0,1;
   t1,0,0,0;
   t2,0,0,0];
B2=[0;0;t3;t4];
B1=[0;0;1;1];

w=0*sin(t);
%State equation for one link inverted pendulum
D=A*x+B1*w+B2*u;
sys(1)=x(3);
sys(2)=x(4);
sys(3)=D(3);
sys(4)=D(4);
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);   %Angle
sys(2)=x(2);   %Cart position
sys(3)=x(3);   %Angle speed 
sys(4)=x(4);   %Cart speed