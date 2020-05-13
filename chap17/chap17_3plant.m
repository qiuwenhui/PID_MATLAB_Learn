function dx=dym(t,x,flag,para)
global A B C D
u=para;
dx=zeros(4,1); 

%State equation for one link inverted pendulum
dx=A*x+B*u;