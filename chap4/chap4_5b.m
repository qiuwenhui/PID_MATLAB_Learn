close all;
clear all;
T=0.001;
Am=1; 

load TDfile;
kk=0;
f=1;
for F=0.1:0.5:30
kk=kk+1;
FF(kk)=F;
w=FF*2*pi;  % in rad./s

for i=5001:1:10000
    fai(1,i-5000) = sin(2*pi*F*i*T);
    fai(2,i-5000) = cos(2*pi*F*i*T);
end
Fai=fai';

fai_in(kk)=0;

Y_out=y(f,5001:1:10000)';
cout=inv(Fai'*Fai)*Fai'*Y_out;
fai_out(kk)=atan(cout(2)/cout(1));       % Phase Frequency(Deg.)

Af(kk)=sqrt(cout(1)^2+cout(2)^2);         % Magnitude Frequency(dB)
mag_e(kk)=20*log10(Af(kk)/Am);            % in dB
ph_e(kk)=(fai_out(kk)-fai_in(kk))*180/pi; % in Deg.

f=f+1;
end
figure(1);
hold on;
subplot(2,1,1); 
semilogx(w,mag_e,'r-.','linewidth',2);grid on;
xlabel('rad./s');ylabel('Mag.(dB.)');
hold on;
subplot(2,1,2);
semilogx(w,ph_e,'r-.','linewidth',2);grid on;
xlabel('rad./s');ylabel('Phase(Deg.)');