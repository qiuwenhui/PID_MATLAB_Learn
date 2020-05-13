clear all;
close all;
 
tol=400*10^(-6);
 
[np,dp]=pade(tol,6);
 
delay=tf(np,dp);
delta=tf(np,dp)-1;
sys=1/delta;
 
figure(1);
bode(1/delta,'r',{5,10^5});grid on;
 
tol1=0.00035;
Q1=tf([3*tol1,1],[tol1^3,3*tol1^2,3*tol1,1]);
hold on;
bode(Q1,'k');
 
tol3=0.00125;
Q3=tf([3*tol3,1],[tol3^3,3*tol3^2,3*tol3,1]);
hold on;
bode(Q3,'b');
 
tol4=0.00425;
Q4=tf([3*tol4,1],[tol4^3,3*tol4^2,3*tol4,1]);
hold on;
bode(Q4,'g');
legend('1/Delta','Q1','Q2','Q3');
