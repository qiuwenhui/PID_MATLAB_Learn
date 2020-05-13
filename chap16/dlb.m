function varargout = dlb(varargin)   % GUI主程序
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dlb_OpeningFcn, ...
                   'gui_OutputFcn',  @dlb_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end 
%-----------------------打开界面------------------------%
function dlb_OpeningFcn(hObject, eventdata, handles, varargin) 
handles.output = hObject;
guidata(hObject, handles);
global h1 h2 h3;
axes(handles.sys1);
axis equal;
axis([0 5 -20 20 0 20]);
grid on;
view(80,30);
reall=15;
ll=4+reall;
v=[0 0 0;0 5 0;3 5 0;3 0 0;0 0 3;0 5 3;3 5 3;3 0 3];
f=[1 2 3 4;2 6 7 3;4 3 7 8;1 5 8 4;1 2 6 5;5 6 7 8];
g_v=[1 2 3;1 3 3;2 3 3;2 2 3;1 2 ll;1 3 ll;2 3 ll;2 2 ll];
g_f=[1 2 3 4;2 6 7 3;4 3 7 8;1 5 8 4;1 2 6 5;5 6 7 8];
h1=patch('Faces',f,'Vertices',v,'FaceColor','b');
h2=patch('Faces',g_f,'Vertices',g_v,'FaceColor','r');
hold on;
[ballx,bally,ballz]=sphere(8);
ballo=[1.5 2.5 ll];
h3=surf(ballx*1.1+ballo(1),bally*1.1+ballo(2),ballz*1.1+ballo(3));
colormap(autumn);

axes(handles.sys3);
sys3data=imread('model.jpg');    %打开倒立摆示意图
image(sys3data);
set(gca,'Xtick',[],'Ytick',[],'box','on');

function varargout = dlb_OutputFcn(hObject, eventdata, handles)   %输出函数
varargout{1} = handles.output;
function normal(hObject, eventdata, handles) %公共调用函数
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
%----------------------------倒立摆模型参数创建---------------------------%
function mc_CreateFcn(hObject, eventdata, handles)  %M,小车质量
normal(hObject, eventdata, handles);
function mc_Callback(hObject, eventdata, handles)   
function l_CreateFcn(hObject, eventdata, handles)   %L，摆杆长度
normal(hObject, eventdata, handles);
function l_Callback(hObject, eventdata, handles)
function mq_CreateFcn(hObject, eventdata, handles)  %m，摆杆质量
normal(hObject, eventdata, handles);
function mq_Callback(hObject, eventdata, handles)
%-------------------------LQR参数创建-------------------------%
function q1_CreateFcn(hObject, eventdata, handles)  %q1
normal(hObject, eventdata, handles);
function q1_Callback(hObject, eventdata, handles)
function q2_CreateFcn(hObject, eventdata, handles)  %q2
normal(hObject, eventdata, handles);
function q2_Callback(hObject, eventdata, handles)   
function q3_CreateFcn(hObject, eventdata, handles)  %q3
normal(hObject, eventdata, handles);
function q3_Callback(hObject, eventdata, handles)
function q4_CreateFcn(hObject, eventdata, handles)  %q4
normal(hObject, eventdata, handles);
function q4_Callback(hObject, eventdata, handles)
function r_CreateFcn(hObject, eventdata, handles)   %R
normal(hObject, eventdata, handles);
function r_Callback(hObject, eventdata, handles)
%-----------------采用LQR,计算增益K------------------%
function lqrok_Callback(hObject, eventdata, handles) 
global A B C D K;
M_str=get(handles.mc,'string');   
M=str2double(M_str);              %获取小车质量M
m_str=get(handles.mq,'string');    
m=str2double(m_str);              %获取摆杆质量m
L_str=get(handles.l,'string');
L=str2double(L_str);              %获取摆杆长度L
q1_str=get(handles.q1,'string');
q1=str2double(q1_str);
q2_str=get(handles.q2,'string');
q2=str2double(q2_str);
q3_str=get(handles.q3,'string');
q3=str2double(q3_str);
q4_str=get(handles.q4,'string');
q4=str2double(q4_str);
R_str=get(handles.r,'string');
R=str2double(R_str);
Q=[q1,0,0,0;0,q2,0,0;0,0,q3,0;0,0,0,q4];
%Inverted Pendulum Model
g=9.8;
I=1/12*m*L^2;  
l=1/2*L;
t1=m*(M+m)*g*l/[(M+m)*I+M*m*l^2];
t2=-m^2*g*l^2/[(m+M)*I+M*m*l^2];
t3=-m*l/[(M+m)*I+M*m*l^2];
t4=(I+m*l^2)/[(m+M)*I+M*m*l^2];

A=[0,1,0,0;t1,0,0,0;0,0,0,1;t2,0,0,0];
B=[0;t3;0;t4];
C=[0,0,1,0];
D=[0];

[K,sz,ez]=lqr(A,B,Q,R);    %利用LQR方法计算K值
set(handles.k1,'string',K(1));
set(handles.k2,'string',K(2));
set(handles.k3,'string',K(3));
set(handles.k4,'string',K(4));  
%--------------------K的创建-----------------------%
function k1_CreateFcn(hObject, eventdata, handles)  %K1
normal(hObject, eventdata, handles);
function k1_Callback(hObject, eventdata, handles)
function k2_CreateFcn(hObject, eventdata, handles)  %K2
normal(hObject, eventdata, handles);
function k2_Callback(hObject, eventdata, handles)
function k3_CreateFcn(hObject, eventdata, handles)  %K3
normal(hObject, eventdata, handles);
function k3_Callback(hObject, eventdata, handles)
function k4_CreateFcn(hObject, eventdata, handles)  %K4
normal(hObject, eventdata, handles);
function k4_Callback(hObject, eventdata, handles)
%------------------------摆角度和小车位置初始值设定-----------------------%
function in_po_CreateFcn(hObject, eventdata, handles) %小车水平位置创建
normal(hObject, eventdata, handles);
function in_po_Callback(hObject, eventdata, handles)  %小车水平位置回调
Current_Val=str2num(get(hObject,'string'));
set(handles.slider_po,'Value',Current_Val);
function slider_po_CreateFcn(hObject, eventdata, handles) %小车水平拖动条创建
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function slider_po_Callback(hObject, eventdata, handles) %小车水平拖动条回调
global h1 h2 h3;
Value=get(hObject,'Value');
set(handles.in_po,'String',Value);
axes(handles.sys1);
axis equal;
axis([0 5 -20 20 0 20]);
reall=15;
ll=4+reall;
v=[0 0 0;0 5 0;3 5 0;3 0 0;0 0 3;0 5 3;3 5 3;3 0 3];
f=[1 2 3 4;2 6 7 3;4 3 7 8;1 5 8 4;1 2 6 5;5 6 7 8];
g_v=[1 2 3;1 3 3;2 3 3;2 2 3;1 2 ll;1 3 ll;2 3 ll;2 2 ll];
g_f=[1 2 3 4;2 6 7 3;4 3 7 8;1 5 8 4;1 2 6 5;5 6 7 8];
delete(h1);delete(h2);delete(h3);
i=get(handles.slider_po,'Value')*10;
bbb=[0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;];
v1=v+bbb;
af=get(handles.slider_ag,'Value');
gt1=0.5*cos(-af)-0.5;
gt2=0.5*sin(-af)-0;
gt3=0.5/cos(af)+(ll-0.5*tan(af))*sin(af)-cos(af)+0.5;
gt4=(ll-0.5*tan(af))*cos(af)+sin(af)-ll;
gt5=0.5/cos(af)+(ll-0.5*tan(af))*sin(af)-0.5;
gt6=(ll-0.5*tan(af))*cos(af)-ll;
jiao=[0 -gt1 -gt2;0 gt1 gt2;0 gt1 gt2;0 -gt1 -gt2;0 gt3 gt4;0 gt5 gt6;0 gt5 gt6;0 gt3 gt4];
g_v1=g_v+jiao+bbb;
h1=patch('Faces',f,'Vertices',v1,'FaceColor','b');
h2=patch('Faces',g_f,'Vertices',g_v1,'FaceColor','r');
hold on;
[ballx,bally,ballz]=sphere(8);
ballo=[1.5 2.5 ll];
bally_1=bally*1.1+i+ballo(2)+ll*sin(af);
ballz_1=ballz*1.1+ll*cos(af);
h3=surf(ballx*1.1+ballo(1),bally_1,ballz_1);
colormap(autumn);

function in_ag_CreateFcn(hObject, eventdata, handles) %摆杆角度创建
normal(hObject, eventdata, handles);
function in_ag_Callback(hObject, eventdata, handles)  %摆杆角度回调
Current_Val=str2num(get(hObject,'string'));
set(handles.slider_ag,'Value',Current_Val);
function slider_ag_CreateFcn(hObject, eventdata, handles) %摆杆角度拖动条创建
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function slider_ag_Callback(hObject, eventdata, handles) %摆杆角度拖动条回调
global h1 h2 h3;
Value=get(hObject,'Value');
set(handles.in_ag,'String',Value);
axes(handles.sys1);
axis equal;
axis([0 5 -20 20 0 20]);
v=[0 0 0;0 5 0;3 5 0;3 0 0;0 0 3;0 5 3;3 5 3;3 0 3];
f=[1 2 3 4;2 6 7 3;4 3 7 8;1 5 8 4;1 2 6 5;5 6 7 8];
reall=15;
ll=4+reall;
g_v=[1 2 3;1 3 3;2 3 3;2 2 3;1 2 ll;1 3 ll;2 3 ll;2 2 ll];
g_f=[1 2 3 4;2 6 7 3;4 3 7 8;1 5 8 4;1 2 6 5;5 6 7 8];
delete(h1);delete(h2);delete(h3);
i=get(handles.slider_po,'Value')*10;
bbb=[0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;];
v1=v+bbb;
af=get(handles.slider_ag,'Value');
gt1=0.5*cos(-af)-0.5;
gt2=0.5*sin(-af)-0;
gt3=0.5/cos(af)+(ll-0.5*tan(af))*sin(af)-cos(af)+0.5;
gt4=(ll-0.5*tan(af))*cos(af)+sin(af)-ll;
gt5=0.5/cos(af)+(ll-0.5*tan(af))*sin(af)-0.5;
gt6=(ll-0.5*tan(af))*cos(af)-ll;
jiao=[0 -gt1 -gt2;0 gt1 gt2;0 gt1 gt2;0 -gt1 -gt2;0 gt3 gt4;0 gt5 gt6;0 gt5 gt6;0 gt3 gt4];
g_v1=g_v+jiao+bbb;
h1=patch('Faces',f,'Vertices',v1,'FaceColor','b');
h2=patch('Faces',g_f,'Vertices',g_v1,'FaceColor','r');
hold on;
[ballx,bally,ballz]=sphere(8);
ballo=[1.5 2.5 ll];
bally_1=bally*1.1+i+ballo(2)+ll*sin(af);
ballz_1=ballz*1.1+ll*cos(af);
h3=surf(ballx*1.1+ballo(1),bally_1,ballz_1);
colormap(autumn);
%-----------------------仿真时间和步长设定------------------------%
function Tedit_CreateFcn(hObject, eventdata, handles) %仿真时间创建
normal(hObject, eventdata, handles);
function Tedit_Callback(hObject, eventdata, handles)  %仿真时间回调
function Step_CreateFcn(hObject, eventdata, handles)  %步长值创建
normal(hObject, eventdata, handles);
function Step_Callback(hObject, eventdata, handles)   %步长值回调
%---------------------------启动仿真-----------------------------% 
function simulate_Callback(hObject, eventdata, handles)
global A B C D K draw1 draw2 draw3 draw4 h1 h2 h3 odraw t;
Tmax_str=get(handles.Tedit,'string');
Tmax=str2double(Tmax_str);
Stepz_str=get(handles.Step,'string');
Stepz=str2double(Stepz_str);
t=0:Stepz:Tmax;

U=zeros(size(t));   %Outer Input Disturbance
At=A-B*K;  %For closed system dx=(A-BK)x+BU, U相当于干扰

Bt=B;
Ct=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
Dt=D;
inpo=get(handles.slider_po,'Value');
inag=get(handles.slider_ag,'Value');
x0=[inag;0;inpo;0];
odraw=lsim(At,Bt,Ct,Dt,U,t,x0);      %Simulation of Control

x1=odraw(:,1);   %Pendulum angle 
x2=odraw(:,2);   %Pendulum angle speed
x3=odraw(:,3);   %Cart position
x4=odraw(:,4);   %Cart speeds

iizz=size(x3);
iiz=iizz(1);
tishi=0;
for ii=1:iiz;   %小车位置限制范围
    if odraw(ii,3)>2|odraw(ii,3)<-2
        boxerr=errordlg('3D动画超出范围');
        waitfor(boxerr);
        tishi=1;
        break;
    end
end
axes(handles.ag);
draw1=plot(t,x1);grid;
axes(handles.av);
draw2=plot(t,x2);grid;
axes(handles.dp);
draw3=plot(t,x3);grid;
axes(handles.dv);
draw4=plot(t,x4);grid;
delete(h1);delete(h2);delete(h3);
axes(handles.sys1);
axis equal;
axis([0 5 -20 20 0 20]);
v=[0 0 0;0 5 0;3 5 0;3 0 0;0 0 3;0 5 3;3 5 3;3 0 3];
f=[1 2 3 4;2 6 7 3;4 3 7 8;1 5 8 4;1 2 6 5;5 6 7 8];
h1=patch('Faces',f,'Vertices',v,'FaceColor','b','EraseMode','normal');
reall=15;
ll=4+reall;
g_v=[1 2 3;1 3 3;2 3 3;2 2 3;1 2 ll;1 3 ll;2 3 ll;2 2 ll];
g_f=[1 2 3 4;2 6 7 3;4 3 7 8;1 5 8 4;1 2 6 5;5 6 7 8];
h2=patch('Faces',g_f,'Vertices',g_v,'FaceColor','r','EraseMode','normal');
hold on;
[ballx,bally,ballz]=sphere(8);
ballo=[1.5 2.5 ll];
h3=surf(ballx*1.1+ballo(1),bally*1.1+ballo(2),ballz*1.1+ballo(3));
set(h3,'EraseMode','normal');
colormap(autumn);
hbar=waitbar(0,'P','color',[0.953,0.953,0.953]);
iizz=size(odraw(:,3));
iiz=iizz(1);
for ii=1:iiz;
    i=odraw(ii,3)*10;
    bbb=[0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;0 i 0;];
    v1=v+bbb;
    set(h1,'Vertices',v1);
    af=odraw(ii,1);
    gt1=0.5*cos(-af)-0.5;
    gt2=0.5*sin(-af)-0;
    gt3=0.5/cos(af)+(ll-0.5*tan(af))*sin(af)-cos(af)+0.5;
    gt4=(ll-0.5*tan(af))*cos(af)+sin(af)-ll;
    gt5=0.5/cos(af)+(ll-0.5*tan(af))*sin(af)-0.5;
    gt6=(ll-0.5*tan(af))*cos(af)-ll;
    jiao=[0 -gt1 -gt2;0 gt1 gt2;0 gt1 gt2;0 -gt1 -gt2;0 gt3 gt4;0 gt5 gt6;0 gt5 gt6;0 gt3 gt4];
    g_v1=g_v+jiao+bbb;
    set(h2,'Vertices',g_v1);    
    bally_1=bally*1.1+i+ballo(2)+ll*sin(af);
    ballz_1=ballz*1.1+ll*cos(af);
    set(h3,'ydata',bally_1,'zdata',ballz_1);
    drawnow;    
    strbar=['T = ',num2str(Tmax/iiz*ii),' s'];
    waitbar(ii/iiz,hbar,strbar);
    set(handles.Ttext,'string',strbar); 
    pause(0.02)  
end
close(hbar);
%--------------重置按钮:实现倒立摆模型参数和LQR参数的重置-------------%
function reset_Callback(hObject, eventdata, handles) 
global draw1 draw2 draw3 draw4 h1 h2;
set(handles.k1,'string','');
set(handles.k2,'string','');
set(handles.k3,'string','');
set(handles.k4,'string','');
set(handles.mc,'string','');
set(handles.mq,'string','');
set(handles.l,'string','');
set(handles.q1,'string','');
set(handles.q2,'string','');
set(handles.q3,'string','');
set(handles.q4,'string','');
set(handles.r,'string','');
delete(draw1);delete(draw2);delete(draw3);delete(draw4);
function exit_Callback(hObject, eventdata, handles)     %退出按钮
close(gcf);
function figure1_CreateFcn(hObject, eventdata, handles) %创建图形