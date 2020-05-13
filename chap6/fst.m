function f=fst(x1,x2,delta,h)
d=delta*h;
d0=h*d;
y=x1+h*x2;
a0=sqrt(d^2+8*delta*abs(y));

if abs(y)>d0
    a=x2+(a0-d)/2*sign(y);
else
    a=x2+y/h;
end

if abs(a)>d
    f=-delta*sign(a);
else
    f=-delta*a/d;
end