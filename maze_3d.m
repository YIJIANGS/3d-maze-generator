clear;clc;close;
a=ones(15,11); %�Թ���С
[m,n]=size(a);
starti=[1 1]; %��ʼ�㣬����Ϊ����
finishi=[15 11]; %�յ�,����Ϊ����
%% ������
gridx=(1:floor(m/2))*2;
a(gridx,:)=0;
gridy=(1:floor(n/2))*2;
a(:,gridy)=0;
%% �����һ����ͨ�е�·
ix=starti(1);
iy=starti(2);
while ix~=finishi(1) || iy~=finishi(2)
    path=randi(6); %����6��״̬��ǰ4��Ϊ����ƶ�����2�ֳ����յ㷽���ƶ�
    switch path
        case 1 %�����ƶ�
            if ix<m-1
                ix=ix+2;
                a(ix-1,iy)=1;
            end
        case 2 %�����ƶ�
            if ix>1
                ix=ix-2;
                a(ix+1,iy)=1;
            end
        case 3 %�����ƶ�
            if iy>1
                iy=iy-2;
                a(ix,iy+1)=1;
            end
        case 4 %�����ƶ�
            if iy<n-1
                iy=iy+2;
                a(ix,iy-1)=1;
            end
        case 5 %���յ�����
            if ix<finishi(1)
                ix=ix+2;
                a(ix-1,iy)=1;
            elseif ix>finishi(1)
                ix=ix-2;
                a(ix+1,iy)=1;
            end
            case 6 %���յ����
            if iy<finishi(2)
                iy=iy+2;
                a(ix,iy-1)=1;
            elseif iy>finishi(2)
                iy=iy-2;
                a(ix,iy+1)=1;
            end
    end
end
%% ����򿪹ؿڣ�ģ���Թ�����

for i=1:20
    gx=gridx(randi(size(gridx,2))); %���������
    gy=gridy(randi(size(gridy,2))); %���������
    a(gx,gy+1)=1;
end
for i=1:20
    gx=gridx(randi(size(gridx,2))); %���������
    gy=gridy(randi(size(gridy,2))); %���������
    a(gx+1,gy)=1;
end
%% ǽ��ͼƬ
wall=imread('wall.jpg');
% wall=imresize(wall,0.5);
%% �Թ�ͼ����һ������ΧΧǽ
b_map=zeros(size(a)+2);
b_map(2:end-1,2:end-1)=a;
b_map(2,1)=1;
b_map(finishi(1)+1,finishi(2)+1:finishi(2)+2)=1;
%% ������һ����Χ�ռ�
b_plus=ones(size(b_map)+2);
b_plus(2:end-1,2:end-1)=b_map;
%% 3Dǽ���λ��
new_m=b_plus;
k2=0;
for i=1:size(b_plus,1)
    for j=1:size(b_plus,2)
        wall_mat=zeros(2,1);
        if new_m(i,j)==0
            if j<size(b_plus,2) && new_m(i,j+1)==0  %ǽ���ұ�����
                k=0;
                n=0;
                while new_m(i,j+n)==0 && j+n<size(b_plus,2)
                    k=k+1;
                    wall_mat(k)=(j+n-1)*size(b_plus,1)+i;
                    new_m(i,j+n)=1;
                    n=n+1;
                end
            elseif i<size(b_plus,1) && new_m(i+1,j)==0 %ǽ���±�����
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
%% ��3Dǽ��
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
