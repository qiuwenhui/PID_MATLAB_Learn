function [sys,x0]=s_function(t,x,u,flag)
kp=60;ki=1;kd=3;
if flag==0
   sys=[0,0,1,3,0,1];   %Outputs=1,Inputs=3,DirFeedthrough=0;
   x0=[];
elseif flag==3
      sys(1)=kp*u(1)+ki*u(2)+kd*u(3);
else
   sys=[];
end