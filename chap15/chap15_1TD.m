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
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1; %关键参数
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0 0 0];%干扰上界估计初值
str = [];
ts  = [0 0];
function sys=mdlDerivatives(t,x,u)
v=u(1);
a1=9;b1=27;c1=27;
kexi=0.01;
 if t<=1
     kexi=1/(100*(1-exp(-2*t)));
 end
sys(1)=x(2);
sys(2)=x(3);
sys(3)=-a1*(x(1)-v)/kexi^3-b1*x(2)/kexi^2-c1*x(3)/kexi;
function sys=mdlOutputs(t,x,u)
v=u(1);
sys(1)=v;
sys(2)=x(2);
sys(3)=x(3);