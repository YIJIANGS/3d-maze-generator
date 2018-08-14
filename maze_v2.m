clear;clc;close;
a=ones(10,10); %�Թ���С
[m,n]=size(a);
starti=[1 1]; %��ʼ�㣬����Ϊ����
finishi=[9 9]; %�յ�,����Ϊ����
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

%% �����400���ؿڣ�ģ���Թ�����

for i=1:200
    gx=gridx(randi(size(gridx,2))); %���������
    gy=gridy(randi(size(gridy,2))); %���������
    a(gx,gy+1)=1;
end
for i=1:200
    gx=gridx(randi(size(gridx,2))); %���������
    gy=gridy(randi(size(gridy,2))); %���������
    a(gx+1,gy)=1;
end

%% ��ֵ�� ת��Ϊrgbͼ
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
%% ������ɫͼƬ
character=imread('funny.jpg');
character=imresize(character,0.06);
c=character(6:30,18:43,:);
%% ģ�����Թ���·
rx=starti(1)+1;
ry=starti(2)+1;
prev=1;
[bm, bn]=size(b_map);

while rx~=finishi(1) || ry~=finishi(2)
    if rx<size(b_map,1)
        cas1=b_map(rx+1,ry)==255; %���������ƶ�
    else cas1=0;
    end
    
    if ry<size(b_map,2)
        cas2=b_map(rx,ry+1)==255; %���������ƶ�
    else cas2=0;
    end
    
    if rx>1
        cas3=b_map(rx-1,ry)==255; %���������ƶ�
    else cas3=0;
    end
    
    if ry>1
        cas4=b_map(rx,ry-1)==255; %���������ƶ�
    else cas4=0;
    end
    
    if cas1 && cas2 && cas3 && cas4 %�������4�������ƶ�
        switch prev
            case 1 
                ry=ry-1; %��һ�������ϣ��������ƶ�
                prev=4;
            case 2
                rx=rx+1; %��һ�������ң��������ƶ�
                prev=1;
            case 3
                ry=ry+1; %��һ�����£��������ƶ�
                prev=2;
            case 4
                rx=rx-1; %��һ�������������ƶ�
                prev=3;
        end
    elseif cas1 && cas2 && cas3 %������ߵ�ǽʱ
        switch prev
            case 1
                rx=rx+1; %��һ�����ϣ�����������
                prev=1;
            case 3
                rx=rx-1; %��һ�����£�����������
                prev=3;
        end
    elseif cas1 && cas3 && cas4 %���ұߵ�ǽʱ
        switch prev
            case 1
                rx=rx+1; %��һ�����ϣ�����������
                prev=1;
            case 3
                rx=rx-1; %��һ�����£�����������
                prev=3;
        end
    elseif cas2 && cas3 && cas4 %���ϱߵ�ǽʱ
        switch prev
            case 2
                ry=ry+1; %��һ�����ң�����������
                prev=2;
            case 4
                ry=ry-1; %��һ�����󣬼���������
                prev=4;
        end
    elseif cas1 && cas2 && cas4 %���±ߵ�ǽʱ
        switch prev
            case 2
                ry=ry+1; %��һ�����ң�����������
                prev=2;
            case 4
                ry=ry-1; %��һ�����󣬼���������
                prev=4;
        end
    elseif cas2 && cas3 %���Ͻ�
        ry=ry+1; %�����ƶ�
        prev=2;
    elseif cas3 && cas4 %���Ͻ�
        rx=rx-1; %�����ƶ�
        prev=3;
    elseif cas1 && cas4 %���½�
        ry=ry-1; %�����ƶ�
        prev=4;
    elseif cas1 && cas2 %���½�
        rx=rx+1;
        prev=1;
    end
    temp_map3=ones(bm+30,bn+30,3)*255;
    temp_map3=uint8(temp_map3);
    temp_map3(15:end-16,15:end-16,:)=a_map3;
    temp_map3(rx+3:rx+27,ry+3:ry+28,:)=c;
    imshow(temp_map3)  
end