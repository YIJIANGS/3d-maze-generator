clear;clc;close;
row=15; %�Թ�������
col=11; %�Թ�������
visited=zeros(row-1,col-1);
maze=ones(row*2+1,col*2+1);
%% �������յ�
maze(2:2:row*2,2:end-1)=0;
maze(2:end-1,2:2:col*2)=0;
maze(3,2)=1;
maze(end-2,end-1)=1;
%%
% for i=0:col
%     line([i i], [0 row])
%     hold on
% end
% for i=0:row
%     line([0 col], [i i])
%     hold on
% end
% plot([0 0],[row-1 row],'w')
% plot([col col],[0 1],'w')
% axis([-1 col+1 -1 row+1])
%%
x=1;
y=1;
while find(visited==0)
move=randi(4);
switch move
    case 1 %�����ƶ�
        if x>1 && visited(x-1,y)==0
            visited(x-1,y)=1;
            x=x-1;
            maze(2*x+2,2*y+1)=1;
        elseif x>1 && maze(2*x,2*y+1)==1
            x=x-1;
        end
    case 2 %�����ƶ�
        if x<row-1 && visited(x+1,y)==0
            visited(x+1,y)=1;
            x=x+1;
            maze(2*x,2*y+1)=1;
        elseif x<row-1 && maze(2*x+2,2*y+1)==1
            x=x+1;
        end
    case 3 %�����ƶ�
        if y>1 && visited(x,y-1)==0
            visited(x,y-1)=1;
            y=y-1;
            maze(2*x+1,2*y+2)=1;
        elseif y>1 && maze(2*x+1,2*y)==1
            y=y-1;
        end
    case 4 %�����ƶ�
        if y<col-1 && visited(x,y+1)==0
            visited(x,y+1)=1;
            y=y+1;
            maze(2*x+1,2*y)=1;
        elseif y<col-1 && maze(2*x+1,2*y+2)==1
            y=y+1;
        end
end
end
%% ��ֵ�� ת��Ϊrgbͼ
a_map=imresize(maze,2);
a_map(a_map>0.5)=255;
a_map(a_map<0.5)=0;
b_map=zeros(size(a_map)+2);
b_map(2:end-1,2:end-1)=a_map;
b_map(end-2:end,end)=255;
for i=1:3
    a_map3(:,:,i)=b_map;
end
%% ������ɫͼƬ
character=imread('funny.jpg');
character=character(100:500,280:700,:);
c=imresize(character,0.07);
size_multi=10; %ͼ�����������
maze3=uint8(imresize(a_map3,size_multi));
%% ����keyboard�¼�
callstr = 'set(gcbf,''Userdata'',double(get(gcbf,''Currentcharacter''))) ; uiresume ' ;
fh = figure(...
    'name','Press a key', ...
    'keypressfcn',callstr, ...
    'windowstyle','modal',...
    'numbertitle','off', ...
    'position',[0 0  1 1],...
    'userdata','timeout') ;
rx=3;
ry=3;
while true
uiwait ;
ch=get(fh,'Userdata') ;  % and the key itself
switch ch
    case 28 %����
        ry=ry-1;
    case 29 %����
        ry=ry+1;
    case 30 %����
        rx=rx-1;
    case 31 %����
        rx=rx+1;
end
show_im=maze3;
show_im(rx*size_multi:rx*size_multi+size(c,1)-1,ry*size_multi:ry*size_multi+size(c,2)-1,:)=c;
% show_im=imshow(temp_map3);
imshow(show_im)
end