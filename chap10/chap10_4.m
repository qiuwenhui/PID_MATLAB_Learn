%PD control based on DE Friction parameters estimation
clear all;
close all;
global yd y timef

F=0.80;      % 变异因子：[1,2]
cr=0.6;      % 交叉因子

Size=30;
CodeL=2;
MinX=zeros(CodeL,1);
MaxX=3.0*ones(CodeL,1);

for i=1:1:CodeL
    kxi(:,i)=MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1);
end

BestS=kxi(1,:); %全局最优个体
BsJ=0;
for i=2:Size
    if chap10_4plant(kxi(i,:),BsJ)<chap10_4plant(BestS,BsJ)        
        BestS=kxi(i,:);
    end
end
BsJ=chap10_4plant(BestS,BsJ);


%进入主要循环，直到满足精度要求
G=50; %最大迭代次数 
for kg=1:1:G
     time(kg)=kg;
%变异
    for i=1:Size
        kx=kxi(i,:);
        r1 = 1;r2=1;r3=1;r4=1;
        while(r1 == r2|| r1 ==r3 || r2 == r3 || r1 == i|| r2 ==i || r3 == i||r4==i ||r1==r4||r2==r4||r3==r4 )
            r1 = ceil(Size * rand(1));
            r2 = ceil(Size * rand(1));
            r3 = ceil(Size * rand(1));
            r4 = ceil(Size * rand(1));
        end
        h(i,:)=BestS+F*(kxi(r1,:)-kxi(r2,:));
        %h(i,:)=X(r1,:)+F*(X(r2,:)-X(r3,:));

        for j=1:CodeL  %检查值是否越界
            if h(i,j)<MinX(j)
                h(i,j)=MinX(j);
            elseif h(i,j)>MaxX(j)
                h(i,j)=MaxX(j);
            end
        end        
%交叉
        for j = 1:1:CodeL
              tempr = rand(1);
              if(tempr<cr)
                  v(i,j) = h(i,j);
               else
                  v(i,j) = kxi(i,j);
               end
        end
%选择        
        if(chap10_4plant(v(i,:),BsJ)<chap10_4plant(kxi(i,:),BsJ))
            kxi(i,:)=v(i,:);
        end
%判断和更新       
       if chap10_4plant(kxi(i,:),BsJ)<BsJ %判断当此时的指标是否为最优的情况
          BsJ=chap10_4plant(kxi(i,:),BsJ);
          BestS=kxi(i,:);
        end
    end
    BestS
    BsJ
    
BsJ_kg(kg)=chap10_4plant(BestS,BsJ);
end
display('ideal value: kx=[0.3,1.5]');
BestS
 
figure(1);
plot(timef,yd,'r',timef,y,'k:','linewidth',2);
xlabel('Time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');
figure(2);
plot(time,BsJ_kg,'r','linewidth',2);
xlabel('Times');ylabel('Best J');