clear all;
close all;
K=10;
tol=1.0;

M=3;
if M==1
    Kp=10;Kd=10;
elseif M==2
    Kp=10;Kd=20;
elseif M==3
    Kp=20;Kd=10;
end