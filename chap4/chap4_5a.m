clear all;
close all;

T=0.001;
Am=1; 

f=1;
for F=0.1:0.5:30
u_1=0;y_1=0;dy_1=0;
for k=1:1:10000
time(k)=k*T;
u(f,k)=Am*sin(1*2*pi*F*k*T);        % Sine Signal with different frequency

%Levant TD
    afa=15;nbd=10;      %From Levant paper
    afa=15;nbd=20;      %From Levant paper    
    y(f,k)=y_1+T*(dy_1-nbd*sqrt(abs(y_1-u(f,k)))*sign(y_1-u(f,k)));
    dy(k)=dy_1-T*afa*sign(y_1-u(f,k));
    dy_1=dy(k);


uk(k)=u(f,k);
yk(k)=y(f,k);

y_1=yk(k);
u_1=uk(k);
end
f=f+1;
end

save TDfile y;