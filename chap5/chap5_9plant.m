function dx=Plant(t,x,flag,para)
dx=zeros(2,1);
J=10;
ut=para(1);
t=para(2);

dt=3.0*sin(t);
dx(1)=x(2);
dx(2)=1/J*(ut-dt);