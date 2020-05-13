close all;

x0=0;
options=foptions;
options(1)=1;
x=fsolve('fun_x',x0,options)