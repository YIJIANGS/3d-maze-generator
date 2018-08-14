function varargout = maze3d(varargin)
% MAZE3D MATLAB code for maze3d.fig
%      MAZE3D, by itself, creates a new MAZE3D or raises the existing
%      singleton*.
%
%      H = MAZE3D returns the handle to a new MAZE3D or the handle to
%      the existing singleton*.
%
%      MAZE3D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAZE3D.M with the given input arguments.
%
%      MAZE3D('Property','Value',...) creates a new MAZE3D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before maze3d_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to maze3d_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help maze3d

% Last Modified by GUIDE v2.5 16-Sep-2017 09:33:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @maze3d_OpeningFcn, ...
                   'gui_OutputFcn',  @maze3d_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before maze3d is made visible.
function maze3d_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to maze3d (see VARARGIN)

% Choose default command line output for maze3d
handles.output = hObject;
wall=imread('wall.jpg');

% axes(handles.axes1)
% imshow('3dmaze.jpg')
axes(handles.axes2)
imshow('wall.jpg')
axes(handles.axes3)
imshow('maze2.png')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes maze3d wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = maze3d_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
index_selected = get(hObject,'Value');
switch index_selected
    case 1
        wall=imread('wall.jpg');
    case 2
        wall=imread('wall2.jpg');
    case 3
        wall=imread('wall3.jpg');
end
axes(handles.axes2)
imshow(wall)
% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function row_Callback(hObject, eventdata, handles)
% hObject    handle to row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of row as text
%        str2double(get(hObject,'String')) returns contents of row as a double


% --- Executes during object creation, after setting all properties.
function row_CreateFcn(hObject, eventdata, handles)
% hObject    handle to row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function col_Callback(hObject, eventdata, handles)
% hObject    handle to col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of col as text
%        str2double(get(hObject,'String')) returns contents of col as a double


% --- Executes during object creation, after setting all properties.
function col_CreateFcn(hObject, eventdata, handles)
% hObject    handle to col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
row = str2double(get(handles.row,'String'));
col= str2double(get(handles.col,'String'));
if row>20 || col>20
    warndlg(sprintf('数字太大，请填写20以内数字'))
else
    visited=zeros(row-1,col-1);
    maze=ones(row*2+1,col*2+1);
    %%
    figure
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
    wall_num=get(handles.listbox1,'value');
    switch wall_num
    case 1
        wall=imread('wall.jpg');
    case 2
        wall=imread('wall2.jpg');
    case 3
        wall=imread('wall3.jpg');
    end
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
            size(find(new_m==0))
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
end
%% 加个地面背景
g_size=size(a_map,1)+20;
axis([-20 g_size+20 -20 g_size+20 -1 2 ])
ground=imread('ground.jpg');
 xImage = [-100 g_size; -100 g_size];   %# The x data for the image corners
yImage = [g_size g_size; -100 -100 ];             %# The y data for the image corners
zImage = [0 0;0 0];   %# The z data for the image corners
surf(xImage,yImage,zImage,...    %# Plot the surface
     'CData',ground,...
     'FaceColor','texturemap');
 hold on


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
row = str2double(get(handles.row,'String'));
col= str2double(get(handles.col,'String'));
if row>20 || col>20
    warndlg(sprintf('数字太大，请填写20以内数字'))
else
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
    axes(handles.axes3)
    imshow(maze)
end
