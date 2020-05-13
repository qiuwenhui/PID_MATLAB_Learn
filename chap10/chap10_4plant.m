function BsJ=pid_fm_def(kx,BsJ)
global yd y timef
a=50;b=400;
ts=0.001; 
sys=tf(b,[1,a,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');

u_1=0;u_2=0;
y_1=0;y_2=0;
e_1=0;
B=0;

G=500;
for k=1:1:G
timef(k)=k*ts;
yd(k)=0.5*sin(2*pi*k*ts);

y(k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
e(k)=yd(k)-y(k);  
de(k)=(e(k)-e_1)/ts;
speed(k)=(y(k)-y_1)/ts;

% Disturbance Signal: Coulomb & Viscous Friction
Ff(k)=sign(speed(k))*(0.30*abs(speed(k))+1.50);

kp=50;kd=0.50;
u(k)=kp*e(k)+kd*de(k);   %PD control
u(k)=u(k)-Ff(k);    % with friction

%kx=[0.3,1.5];   %Idea Identification
Ffc(k)=sign(speed(k))*(kx(1)*abs(speed(k))+kx(2)); 

u(k)=u(k)+Ffc(k)*1.0;  %With friction compensation
    
u_2=u_1;u_1=u(k);
y_2=y_1;y_1=y(k);
e_1=e(k);
end
for i=1:1:G
   Ji(i)=0.999*abs(e(i))+0.01*u(i)^2*0.1;
   B=B+Ji(i);   
end
BsJ=B;