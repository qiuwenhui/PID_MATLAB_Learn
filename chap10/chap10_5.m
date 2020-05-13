clear all;
close all
x = 0:10;
y = sin(x);
xx = 0:0.25:10;
yy = spline(x,y,xx);
plot(x,y,'o',xx,yy,'k','linewidth',2);