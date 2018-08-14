clear;clc;close;
a=ones(10,10); %迷宫大小
[m,n]=size(a);
starti=[1 1]; %开始点，坐标为单数
finishi=[9 9]; %终点,坐标为单数
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

%% 随机打开400个关口，模拟迷宫干扰

for i=1:200
    gx=gridx(randi(size(gridx,2))); %随机纵坐标
    gy=gridy(randi(size(gridy,2))); %随机横坐标
    a(gx,gy+1)=1;
end
for i=1:200
    gx=gridx(randi(size(gridx,2))); %随机纵坐标
    gy=gridy(randi(size(gridy,2))); %随机横坐标
    a(gx+1,gy)=1;
end

%% 二值化 转换为rgb图
a_map=imresize(a,15);
a_map(a_map>0.5)=255;
a_map(a_map<0.5)=0;
b_map=zeros(size(a_map)+2);
b_map(2:end-1,2:end-1)=a_map;
b_map(end-2:end,end)=255;
b_map=uint8(b_map);
for i=1:3
    a_map3(:,:,i)=b_map;
end
imshow(a_map3)
%% 创建角色图片
character=imread('funny.jpg');
character=imresize(character,0.06);
c=character(6:30,18:43,:);
%% 模拟找迷宫出路
rx=starti(1)+1;
ry=starti(2)+1;
prev=1;
[bm, bn]=size(b_map);

while rx~=finishi(1) || ry~=finishi(2)
    if rx<size(b_map,1)
        cas1=b_map(rx+1,ry)==255; %可以向上移动
    else cas1=0;
    end
    
    if ry<size(b_map,2)
        cas2=b_map(rx,ry+1)==255; %可以向右移动
    else cas2=0;
    end
    
    if rx>1
        cas3=b_map(rx-1,ry)==255; %可以向下移动
    else cas3=0;
    end
    
    if ry>1
        cas4=b_map(rx,ry-1)==255; %可以向左移动
    else cas4=0;
    end
    
    if cas1 && cas2 && cas3 && cas4 %如果能往4个方向移动
        switch prev
            case 1 
                ry=ry-1; %上一步是向上，则往左移动
                prev=4;
            case 2
                rx=rx+1; %上一步是向右，则往上移动
                prev=1;
            case 3
                ry=ry+1; %上一步往下，则向右移动
                prev=2;
            case 4
                rx=rx-1; %上一步往左，则向下移动
                prev=3;
        end
    elseif cas1 && cas2 && cas3 %贴着左边的墙时
        switch prev
            case 1
                rx=rx+1; %上一步向上，继续往上走
                prev=1;
            case 3
                rx=rx-1; %上一步向下，继续往下走
                prev=3;
        end
    elseif cas1 && cas3 && cas4 %贴右边的墙时
        switch prev
            case 1
                rx=rx+1; %上一步向上，继续往上走
                prev=1;
            case 3
                rx=rx-1; %上一步向下，继续往下走
                prev=3;
        end
    elseif cas2 && cas3 && cas4 %贴上边的墙时
        switch prev
            case 2
                ry=ry+1; %上一步向右，继续往右走
                prev=2;
            case 4
                ry=ry-1; %上一步向左，继续往左走
                prev=4;
        end
    elseif cas1 && cas2 && cas4 %贴下边的墙时
        switch prev
            case 2
                ry=ry+1; %上一步向右，继续往右走
                prev=2;
            case 4
                ry=ry-1; %上一步向左，继续往左走
                prev=4;
        end
    elseif cas2 && cas3 %左上角
        ry=ry+1; %向右移动
        prev=2;
    elseif cas3 && cas4 %右上角
        rx=rx-1; %向下移动
        prev=3;
    elseif cas1 && cas4 %右下角
        ry=ry-1; %向左移动
        prev=4;
    elseif cas1 && cas2 %左下角
        rx=rx+1;
        prev=1;
    end
    temp_map3=ones(bm+30,bn+30,3)*255;
    temp_map3=uint8(temp_map3);
    temp_map3(15:end-16,15:end-16,:)=a_map3;
    temp_map3(rx+3:rx+27,ry+3:ry+28,:)=c;
    imshow(temp_map3)  
end