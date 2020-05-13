function dy=DynamicModel(t,y,flag,para)
global S
dy=zeros(7,1);

S=1;   
switch S
case 1
   r=1.0*sign(sin(0.05*t*2*pi));    %Square Signal
case 2
   r=1.0*sin(1.0*t*2*pi);           %Sin Signal
end
p12=para(4);
p22=para(5);

e=y(1)-y(3);
de=y(2)-y(4);
eF=p12*e+p22*de;

k0=y(5);
k1=y(6);
k2=y(7);
u=k0*r+k1*y(3)+k2*y(4);

b1=para(1);b2=para(2);b=para(3);
dy(1)=y(2);    %Reference Model
dy(2)=b*r-b1*y(2)-b2*y(1);

a1=20;a2=25;a=133;   
dy(3)=y(4);          %Practical Plant
dy(4)=-a2*y(3)-a1*y(4)+a*u;

dy(5)=200*eF*r;       %k0
dy(6)=200*eF*y(3);    %k1
dy(7)=200*eF*y(4);    %k2