clear;clc;close;
map=imread('maze2.png'); %读取迷宫图
% map=imresize(map,0.8); %读取的迷宫图太大时需要缩小尺寸 加快运行速度
map=rgb2gray(map);
map=map>155;
b_plus=map;
%% 墙面图片
wall=imread('wall.jpg');
% wall=imresize(wall,0.5);

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
%% 加个地面背景
g_size=size(a_map,1)+100;
axis([-100 g_size+100 -100 g_size+100 -1 2 ])
ground=imread('ground.jpg');
 xImage = [-100 g_size; -100 g_size];   %# The x data for the image corners
yImage = [g_size g_size; -100 -100 ];             %# The y data for the image corners
zImage = [0 0;0 0];   %# The z data for the image corners
surf(xImage,yImage,zImage,...    %# Plot the surface
     'CData',ground,...
     'FaceColor','texturemap');
 hold on
