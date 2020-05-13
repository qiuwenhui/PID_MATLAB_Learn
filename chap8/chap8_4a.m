%Fuzzy Tunning PI Control
clear all;
close all;
a=newfis('fuzzpid');

a=addvar(a,'input','e',[-1,1]);                        %Parameter e
a=addmf(a,'input',1,'N','zmf',[-1,-1/3]);
a=addmf(a,'input',1,'Z','trimf',[-2/3,0,2/3]);
a=addmf(a,'input',1,'P','smf',[1/3,1]);

a=addvar(a,'input','ec',[-1,1]);                       %Parameter ec
a=addmf(a,'input',2,'N','zmf',[-1,-1/3]);
a=addmf(a,'input',2,'Z','trimf',[-2/3,0,2/3]);
a=addmf(a,'input',2,'P','smf',[1/3,1]);

a=addvar(a,'output','kp',1/3*[-10,10]);                %Parameter kp
a=addmf(a,'output',1,'N','zmf',1/3*[-10,-3]);
a=addmf(a,'output',1,'Z','trimf',1/3*[-5,0,5]);
a=addmf(a,'output',1,'P','smf',1/3*[3,10]);

a=addvar(a,'output','ki',1/30*[-3,3]);                 %Parameter ki
a=addmf(a,'output',2,'N','zmf',1/30*[-3,-1]);
a=addmf(a,'output',2,'Z','trimf',1/30*[-2,0,2]);
a=addmf(a,'output',2,'P','smf',1/30*[1,3]);

rulelist=[1 1 1 2 1 1;
          1 2 1 2 1 1;
          1 3 1 2 1 1;
          
          2 1 1 3 1 1;
          2 2 3 3 1 1;
          2 3 3 3 1 1;
          
          3 1 3 2 1 1; 
          3 2 3 2 1 1;
          3 3 3 2 1 1];
a=addrule(a,rulelist);
a=setfis(a,'DefuzzMethod','centroid');
writefis(a,'fuzzpid');

a=readfis('fuzzpid');
figure(1);
plotmf(a,'input',1);
figure(2);
plotmf(a,'input',2);
figure(3);
plotmf(a,'output',1);
figure(4);
plotmf(a,'output',2);
figure(5);
plotfis(a);

fuzzy fuzzpid;
showrule(a)
ruleview fuzzpid;