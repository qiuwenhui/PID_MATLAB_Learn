function dx=Plant(t,x,flag,para)
dx=zeros(2,1);
J=0.10;
ut=para(1);
t=para(2);

dt=3.0*sin(t);

b=1/J;
fx=-1/J*dt;
dx(1)=x(2);
dx(2)=fx+b*ut;