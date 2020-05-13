function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {1,2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 12;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
qd1=u(1);
d_qd1=u(2);
dd_qd1=u(3);
qd2=u(4);
d_qd2=u(5);
dd_qd2=u(6);

q1=u(7);
d_q1=u(8);
q2=u(9);
d_q2=u(10);

e1=qd1-q1;
e2=qd2-q2;
de1=d_qd1-d_q1;
de2=d_qd2-d_q2;
e=[e1;e2];
de=[de1;de2];
Fai=5*eye(2);
r=de+Fai*e;

dqd=[d_qd1;d_qd2];
dqr=dqd+Fai*e;
ddqd=[dd_qd1;dd_qd2];
ddqr=ddqd+Fai*de;

p=[2.9 0.76 0.87 3.04 0.87];
g=9.8;
D=[p(1)+p(2)+2*p(3)*cos(q2) p(2)+p(3)*cos(q2);
   p(2)+p(3)*cos(q2) p(2)];
C=[-p(3)*d_q2*sin(q2) -p(3)*(d_q1+d_q2)*sin(q2);
    p(3)*d_q1*sin(q2)  0];
G=[p(4)*g*cos(q1)+p(5)*g*cos(q1+q2);
   p(5)*g*cos(q1+q2)];
tolm=D*ddqr+C*dqr+G;

Kr=15;
tolr=Kr*sign(r);

Kp=100*eye(2);
Ki=100*eye(2);

I=[u(11);u(12)];
tol=tolm+Kp*r+Ki*I+tolr;

sys(1)=tol(1);
sys(2)=tol(2);