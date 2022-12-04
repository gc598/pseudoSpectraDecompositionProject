function varargout = pseudo_gui(varargin)
% PSEUDO_GUI MATLAB code for pseudo_gui.fig
%      PSEUDO_GUI, by itself, creates a new PSEUDO_GUI or raises the existing
%      singleton*.
%
%      H = PSEUDO_GUI returns the handle to a new PSEUDO_GUI or the handle to
%      the existing singleton*.
%
%      PSEUDO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PSEUDO_GUI.M with the given input arguments.
%
%      PSEUDO_GUI('Property','Value',...) creates a new PSEUDO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pseudo_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pseudo_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pseudo_gui

% Last Modified by GUIDE v2.5 23-Jun-2016 14:46:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pseudo_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @pseudo_gui_OutputFcn, ...
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


% --- Executes just before pseudo_gui is made visible.
function pseudo_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pseudo_gui (see VARARGIN)
clc
handles.mode='fullSVD';
%handles.output = hObject;
%axis off;
%h1 = text('Interpreter','latex',...
%'String','$$\epsilon$$',...
%'Position',[0 0.5],...
%'FontSize',16);
handles.xmin=0;
handles.xmax=0;
handles.ymin=0;
handles.ymax=0;
handles.eps=0.1;
handles.m=10;
handles.A=varargin{1};
handles.current_data_eps=0;
handles.current_data_m=handles.m;
tic;
fullSVD(handles.current_data_m,handles.current_data_eps,handles.A);
handles.time=toc;
set(handles.text_time,'String',handles.time);
% Choose default command line output for pseudo_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pseudo_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pseudo_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_eps_Callback(hObject, eventdata, handles)
% hObject    handle to slider_eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%handles = guidata(hObject); %%取出handles
eps=get(hObject,'Value');
set(handles.text_eps,'String',eps);
m=round(get(handles.slider_m,'Value'));

handles.current_data_eps=eps;
if(handles.xmin==0)
    switch(handles.mode)
        case 'fullSVD'
            tic;
            fullSVD(m,handles.current_data_eps,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration'
            tic;
            inverseIteration (m,handles.current_data_eps,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'fullSVD3D'
            tic;
            fullSVD3D(m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration3D'
            tic;
            inverseIteration3D(m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'continuation'
            tic;
            delete(gca);
            continuationTest(handles.current_data_m,handles.current_data_eps,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
    end
else 
     switch(handles.mode)
        case 'fullSVD'
            tic;
            fullSVD_zoom(m,handles.current_data_eps,handles.A,handles.xmin,handles.xmax,handles.ymin,handles.ymax);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration'
            tic;
            inverseIteration_zoom (m,handles.current_data_eps,handles.A,handles.xmin,handles.xmax,handles.ymin,handles.ymax);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'fullSVD3D'
            tic;
            fullSVD3D(m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration3D'
            tic;
            inverseIteration3D(m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'continuation'
            tic;
            delete(gca);
            continuationTest(handles.current_data_m,handles.current_data_eps,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
     end
end
guidata(hObject, handles);
%if isequal(handles.mode,'fullSVD')
 %   fullSVD(m,handles.current_data_eps,handles.A);

%else if isequal(handles.mode,'inverse') 
 %       inverseIteration (m,handles.current_data_eps,handles.A);

  %  else if isequal(handles.mode,'fullSVD3D')
   %         fullSVD3D(m,handles.A);

    %    else if isequal(handles.mode,'inverse3D')
     %   inverseIteration3D(m,handles.A);
      %       end
       % end
    %end
%end

% --- Executes during object creation, after setting all properties.
function slider_eps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in button_fullSVD.
function button_fullSVD_Callback(hObject, eventdata, handles)
% hObject    handle to button_fullSVD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mode='fullSVD';
set(handles.text_eps,'Visible','on');
set(handles.slider_eps,'Visible','on');
reset(gca);
tic;
fullSVD(handles.current_data_m,handles.current_data_eps,handles.A);
handles.time=toc;
set(handles.text_time,'String',handles.time);
guidata(hObject, handles);


% --- Executes on button press in bouton_inverse.
function bouton_inverse_Callback(hObject, eventdata, handles)
% hObject    handle to bouton_inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mode='inverseIteration';
reset(gca);
tic;
inverseIteration(handles.current_data_m,handles.current_data_eps,handles.A);
handles.time=toc;
set(handles.text_time,'String',handles.time);
guidata(hObject, handles);


% --- Executes on slider movement.
function slider_m_Callback(hObject, eventdata, handles)
% hObject    handle to slider_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

m=round(get(hObject,'Value'));
%if rem(m,1)~=0
    
set(handles.text_m,'String',round(m));
%end
handles.current_data_m=round(m);
%eps=get(handles.slider_eps,'Value');
if(handles.xmin==0)
    switch(handles.mode)
        case 'fullSVD'
            tic;
            fullSVD(m,handles.current_data_eps,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration'
            tic;
            inverseIteration (m,handles.current_data_eps,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'fullSVD3D'
            tic;
            fullSVD3D(m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration3D'
            tic;
            inverseIteration3D(m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'continuation'
            tic;
            reset(gca);
            continuationTest(handles.current_data_m,handles.current_data_eps,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
    end
else 
     switch(handles.mode)
        case 'fullSVD'
            tic;
            fullSVD_zoom(m,handles.current_data_eps,handles.A,handles.xmin,handles.xmax,handles.ymin,handles.ymax);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration'
            tic;
            inverseIteration_zoom (m,handles.current_data_eps,handles.A,handles.xmin,handles.xmax,handles.ymin,handles.ymax);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'fullSVD3D'
            tic;
            fullSVD3D(m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration3D'
            tic;
            inverseIteration3D(m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'continuation'
            tic;
            delete(gca);
            continuationTest(handles.current_data_m,handles.current_data_eps,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
     end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in bouton_fullSVD3D.
function bouton_fullSVD3D_Callback(hObject, eventdata, handles)
% hObject    handle to bouton_fullSVD3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mode='fullSVD3D';

set(handles.text_eps,'Visible','off');
set(handles.slider_eps,'Visible','off');
reset(gca);
tic;
fullSVD3D(handles.current_data_m,handles.A);
handles.time=toc;
set(handles.text_time,'String',handles.time);
guidata(hObject, handles);


% --- Executes on button press in bouton_inverse3D.
function bouton_inverse3D_Callback(hObject, eventdata, handles)
% hObject    handle to bouton_inverse3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mode='inverse3D';
reset(gca);
tic;
inverseIteration3D(handles.current_data_m,handles.A);
handles.time=toc;
set(handles.text_time,'String',handles.time);
guidata(hObject, handles);


% --------------------------------------------------------------------
function uitoggletool9_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[xbox,ybox,prect]=getbox;
handles.xmin=xbox(1);
handles.xmax=xbox(2);
handles.ymin=ybox(1);
handles.ymax=ybox(2);
switch(handles.mode)
        case 'fullSVD'
            tic;
            fullSVD_zoom(handles.current_data_m,handles.current_data_eps,handles.A,handles.xmin,handles.xmax,handles.ymin,handles.ymax);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration'
            tic;
            inverseIteration_zoom (handles.current_data_m,handles.current_data_eps,handles.A,handles.xmin,handles.xmax,handles.ymin,handles.ymax);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'fullSVD3D'
            tic;
            fullSVD3D(handles.current_data_m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration3D'
            tic;
            inverseIteration3D(handles.current_data_m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'continuation'
            tic;
            reset(gca);
            
            continuationTest_zoom(handles.current_data_m,handles.current_data_eps,handles.A,handles.xmin,handles.xmax,handles.ymin,handles.ymax);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
end
%h=zoom;
%setAxesZoomMotion(h,gca,'both');
%zoom on
%set(h,'direction','in');
%X=get(gca,'XLim');
%handles.xmin=X(1);
%handles.xmax=X(2);
%Y=get(gca,'YLim');
%handles.ymin=Y(1);
%handles.ymax=Y(2);

guidata(hObject, handles);



%function WindowButtonMotionFcn(hObject, eventdata, handles) 
%pt = get(gca,'CurrentPoint');    %获取当前点坐标 
%x = pt(1,1); 
%y = pt(1,2); 






%setAllowAxesZoom(h,handles.axes_img,0);

%X=get(handles.axes_img,'XLim');
%xmin=X(1);
%xmax=X(2);
%Y=get(handles.axes_img,'YLim');
%ymin=Y(1);
%ymax=Y(2);
%fullSVD_zoom(handles.current_data_m,handles.eps,handles.A,xmin,xmax,ymin,ymax);

%set(gcf,'WindowButtonDownFcn',@ButtonDownFcn); 
%function ButtonDownFcn(src,event) 
%global xini;
%global yini;
%pt = get(gca,'CurrentPoint');    %获取当前点坐标 
%xini = pt(1,1); 
%yini = pt(1,2); 
%set(gcf,'WindowButtonUpFcn',@ButtonUpFcn); 
%function ButtonUpFcn(src,event) 
%global xfin;
%global yfin;
%pt = get(gca,'CurrentPoint');    %获取当前点坐标 
%xfin = pt(1,1); 
%yfin = pt(1,2); 
%fullSVD_zoom(handles.current_data_m,handles.eps,handles.A,xini,xfin,yini,yfin);
%h = zoom;
%setAxesZoomMotion(h,handles.axes_img,'both');%horizontal和vertical都放大
%zoom on
%set(h,'direction','in');


% --------------------------------------------------------------------
function uitoggletool10_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
reset(gca);
switch(handles.mode)
        case 'fullSVD'
            tic;
            fullSVD(handles.current_data_m,handles.current_data_eps,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration'
            tic;
            inverseIteration (handles.current_data_m,handles.current_data_eps,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'fullSVD3D'
            tic;
            fullSVD3D(handles.current_data_m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'inverseIteration3D'
            tic;
            inverseIteration3D(handles.current_data_m,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
        case 'continuation'
            tic;
            continuationTest(handles.current_data_m,handles.current_data_eps,handles.A);
            handles.time=toc;
            set(handles.text_time,'String',handles.time);
            
end
handles.xmin=0;
handles.xmax=0;
handles.ymin=0;
handles.ymax=0;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function text_titre_CreateFcn(hObject, eventdata, handles)

% hObject    handle to text_titre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_t_CreateFcn(hObject, eventdata, handles)

% hObject    handle to text_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_continuation.
function pushbutton_continuation_Callback(hObject, eventdata, handles)
handles.mode='continuation';
set(handles.text_eps,'Visible','on');
set(handles.slider_eps,'Visible','on');
delete(gca);
tic;
continuationTest(handles.current_data_m,handles.current_data_eps,handles.A);
handles.time=toc;
set(handles.text_time,'String',handles.time);
guidata(hObject, handles);

% hObject    handle to pushbutton_continuation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
