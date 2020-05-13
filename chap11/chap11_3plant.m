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
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0;0];
str = [];
ts  = [0 0];
function sys=mdlDerivatives(t,x,u)
%Servo system Parameters
J=0.6;Ce=1.2;Km=6;
Ku=11;R=7.77;
kv=2.0;

alfa=0.01;
a1=1.0;  %Effect on the shape of friction curve
Fm=20;
Fc=15;
kv=2.0;
ut=u(1);
F=ut;
if abs(x(2))<=alfa
   if F>Fm
      Ff=Fm;
   elseif F<-Fm
      Ff=-Fm;
   else
      Ff=F;
   end      
end
if x(2)>alfa   
   Ff=Fc+(Fm-Fc)*exp(-a1*x(2))+kv*x(2);
elseif x(2)<-alfa   
   Ff=-Fc-(Fm-Fc)*exp(a1*x(2))+kv*x(2);
end

sys(1)=x(2);
sys(2)=-Km*Ce/(J*R)*x(2)+Ku*Km*ut/(J*R)-Ff/J;
function sys=mdlOutputs(t,x,u)

%Servo system Parameters
J=0.6;Ce=1.2;Km=6;
Ku=11;R=7.77;
kv=2.0;

alfa=0.01;
a1=1.0;  %Effect on the shape of friction curve
Fm=20;
Fc=15;
kv=2.0;

ut=u(1);
F=ut;
if abs(x(2))<=alfa
   if F>Fm
      Ff=Fm;
   elseif F<-Fm
      Ff=-Fm;
   else
      Ff=F;
   end      
end
if x(2)>alfa   
   Ff=Fc+(Fm-Fc)*exp(-a1*x(2))+kv*x(2);
elseif x(2)<-alfa   
   Ff=-Fc-(Fm-Fc)*exp(a1*x(2))+kv*x(2);
end

sys(1)=x(1);   %Angle
sys(2)=x(2);   %Angle speed
sys(3)=Ff;     %Friction force