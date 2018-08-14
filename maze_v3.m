clear;clc;close;
row=5; %迷宫的列数
col=5; %迷宫的行数
visited=zeros(row-1,col-1);
maze=ones(row*2+1,col*2+1);
%%
maze(2:2:row*2,2:end-1)=0;
maze(2:end-1,2:2:col*2)=0;
maze(3,2)=1;
maze(end-2,end-1)=1;

%%
x=1;
y=1;
while find(visited==0)
move=randi(4);
switch move
    case 1 %向上移动
        if x>1 && visited(x-1,y)==0
            visited(x-1,y)=1;
            x=x-1;
            maze(2*x+2,2*y+1)=1;
        elseif x>1 && maze(2*x,2*y+1)==1
            x=x-1;
        end
    case 2 %向下移动
        if x<row-1 && visited(x+1,y)==0
            visited(x+1,y)=1;
            x=x+1;
            maze(2*x,2*y+1)=1;
        elseif x<row-1 && maze(2*x+2,2*y+1)==1
            x=x+1;
        end
    case 3 %向左移动
        if y>1 && visited(x,y-1)==0
            visited(x,y-1)=1;
            y=y-1;
            maze(2*x+1,2*y+2)=1;
        elseif y>1 && maze(2*x+1,2*y)==1
            y=y-1;
        end
    case 4 %向右移动
        if y<col-1 && visited(x,y+1)==0
            visited(x,y+1)=1;
            y=y+1;
            maze(2*x+1,2*y)=1;
        elseif y<col-1 && maze(2*x+1,2*y+2)==1
            y=y+1;
        end
end
end
%% 墙面图片
wall=imread('wall.jpg');
while size(wall,1)*size(wall,2)>18000
    wall=imresize(wall,0.5);
end
%% 3D墙面的位置
new_m=maze;
k2=0;
for i=1:size(maze,1)
    for j=1:size(maze,2)
        wall_mat=zeros(1,1);
        if new_m(i,j)==0
            k=0;
            n=0;
            if j<size(maze,2) && new_m(i,j+1)==0  %墙往右边延伸
                while new_m(i,j+n)==0 && j+n<size(maze,2)
                    k=k+1;
                    wall_mat(k)=(j+n-1)*size(maze,1)+i;
                    new_m(i,j+n)=1;
                    n=n+1;
                end
            elseif i<size(maze,1) && new_m(i+1,j)==0 %墙往下边延伸
                while new_m(i+n,j)==0 && i+n<size(maze,1)
                    k=k+1;
                    wall_mat(k)=(j-1)*size(maze,1)+i+n;
                    new_m(i+n,j)=1;
                    n=n+1;
                end
            else
                wall_mat=(j-1)*size(maze,1)+i;
                new_m(i,j)=1;
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
            b=zeros(size(maze));
            b(wall3d{i})=1;
            a_map=imresize(b,7);
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
