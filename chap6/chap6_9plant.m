function dy = PlantModel(t,y,flag,p1,p2)
ut=p1;
time=p2;
dy=zeros(2,1);

f=-25*y(2)+33*sin(pi*p2);    %Uunknown part
b=133;
dy(1)=y(2);
dy(2)=f+b*ut;