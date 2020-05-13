%Flight Simulator Servo System
clear all;
close all;

J=2;
b=0.5;

kv=2;
kp=15;
kd=6;

f1=(b+kd*kv);
f2=J;