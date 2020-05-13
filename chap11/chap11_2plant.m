function dx=Model(t,x)
global w A alfa J Ce R Km Ku S a1 Fm Fc M kv
persistent aa
dx=zeros(3,1);

a1=1.0;  %Effect on the shape of friction curve
Fm=20;
Fc=15;
kv=2.0;

F=J*x(3);
if t==0
   aa=0;
end
dF=J*aa;

if abs(x(2))<=alfa
   if F>Fm
      Ff=Fm;
      dFf=0;
   elseif F<-Fm
      Ff=-Fm;
      dFf=0;
   else
      Ff=F;
      dFf=dF;
   end      
end
if x(2)>alfa   
   Ff=Fc+(Fm-Fc)*exp(-a1*x(2))+kv*x(2);
   dFf=(Fm-Fc)*exp(-a1*x(2))*(-a1)*x(3)+kv*x(3);
elseif x(2)<-alfa   
   Ff=-Fc-(Fm-Fc)*exp(a1*x(2))+kv*x(2);
   dFf=-(Fm-Fc)*exp(a1*x(2))*a1*x(3)+kv*x(3);
end

if S==1
   yd=A*sin(w*t);
   dyd=A*w*cos(w*t);
   ddyd=-A*w*w*sin(w*t);
   dddyd=-A*w*w*w*cos(w*t);
end
if S==2
   yd=1;
   dyd=0;
   ddyd=0;
   dddyd=0;
end
if S==3
   yd=A*sign(sin(0.4*2*pi*t));
   dyd=0;
   ddyd=0;
   dddyd=0;
end
error=yd-x(1);
derror=dyd-x(2);
dderror=ddyd-x(3);

u=200*error+40*derror;   %PID
du=200*derror+40*dderror;

if u>=110   
   u=110;
end
if u<=-110
   u=-110;
end

if M==0
   Ff=0;dFf=0;   %No Friction
end
dx(1)=x(2);
dx(2)=-Km*Ce/(J*R)*x(2)+Ku*Km*u/(J*R)-Ff/J;
dx(3)=-Km*Ce/(J*R)*x(3)+Ku*Km*du/(J*R)-dFf/J;
aa=dx(3);