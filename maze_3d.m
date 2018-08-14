clear;clc;close;
a=ones(15,11); %迷宫大小
[m,n]=size(a);
starti=[1 1]; %开始点，坐标为单数
finishi=[15 11]; %终点,坐标为单数
%% 画格子
gridx=(1:floor(m/2))*2;
a(gridx,:)=0;
gridy=(1:floor(n/2))*2;
a(:,gridy)=0;
%% 先随机一条可通行的路
ix=starti(1);
iy=starti(2);
while ix~=finishi(1) || iy~=finishi(2)
    path=randi(6); %设置6种状态，前4种为随机移动，后2种朝着终点方向移动
    switch path
        case 1 %朝上移动
            if ix<m-1
                ix=ix+2;
                a(ix-1,iy)=1;
            end
        case 2 %朝下移动
            if ix>1
                ix=ix-2;
                a(ix+1,iy)=1;
            end
        case 3 %朝左移动
            if iy>1
                iy=iy-2;
                a(ix,iy+1)=1;
            end
        case 4 %朝右移动
            if iy<n-1
                iy=iy+2;
                a(ix,iy-1)=1;
            end
        case 5 %朝终点纵移
            if ix<finishi(1)
                ix=ix+2;
                a(ix-1,iy)=1;
            elseif ix>finishi(1)
                ix=ix-2;
                a(ix+1,iy)=1;
            end
            case 6 %朝终点横移
            if iy<finishi(2)
                iy=iy+2;
                a(ix,iy-1)=1;
            elseif iy>finishi(2)
                iy=iy-2;
                a(ix,iy+1)=1;
            end
    end
end
%% 随机打开关口，模拟迷宫干扰

for i=1:20
    gx=gridx(randi(size(gridx,2))); %随机纵坐标
    gy=gridy(randi(size(gridy,2))); %随机横坐标
    a(gx,gy+1)=1;
end
for i=1:20
    gx=gridx(randi(size(gridx,2))); %随机纵坐标
    gy=gridy(randi(size(gridy,2))); %随机横坐标
    a(gx+1,gy)=1;
end
%% 墙面图片
wall=imread('wall.jpg');
% wall=imresize(wall,0.5);
%% 迷宫图扩大一格当做外围围墙
b_map=zeros(size(a)+2);
b_map(2:end-1,2:end-1)=a;
b_map(2,1)=1;
b_map(finishi(1)+1,finishi(2)+1:finishi(2)+2)=1;
%% 再扩大一格当外围空间
b_plus=ones(size(b_map)+2);
b_plus(2:end-1,2:end-1)=b_map;
%% 3D墙面的位置
new_m=b_plus;
k2=0;
for i=1:size(b_plus,1)
    for j=1:size(b_plus,2)
        wall_mat=zeros(2,1);
        if new_m(i,j)==0
            if j<size(b_plus,2) && new_m(i,j+1)==0  %墙往右边延伸
                k=0;
                n=0;
                while new_m(i,j+n)==0 && j+n<size(b_plus,2)
                    k=k+1;
                    wall_mat(k)=(j+n-1)*size(b_plus,1)+i;
                    new_m(i,j+n)=1;
                    n=n+1;
                end
            elseif i<size(b_plus,1) && new_m(i+1,j)==0 %墙往下边延伸
                k=0;
                n=0;
                while new_m(i+n,j)==0 && i+n<size(b_plus,2)
                    k=k+1;
                    wall_mat(k)=(j-1)*size(b_plus,1)+i+n;
                    new_m(i+n,j)=1;
                    n=n+1;
                end
            end
            if wall_mat~=0
            k2=k2+1;
            wall3d{k2}=wall_mat;
            end
        end
    end
end
%% 画3D墙面
for i=1:size(wall3d,2)
            b=zeros(size(b_plus));
            b(wall3d{i})=1;
            a_map=imresize(b,10);
            a_map=a_map>0.5;
            BW1 = edge(a_map,'prewitt');
            [x3,y3]=find(BW1==1);
            z1=zeros(size(x3));
            z2=ones(size(x3));
            x=[x3 x3];
            y=[y3 y3];
            z=[z1 z2];
            warp(x,y,z,wall)
            hold on
end
