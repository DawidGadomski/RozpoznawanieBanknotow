function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 03-May-2020 17:18:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;
 

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global ref_img_10_front;
     ref_img_10_front = imread('D:\PWR\Obrazki\Projekt\Banknoty\10zlfoto\10_base_front.jpg');
    global ref_img_10_back;
    ref_img_10_back = imread('D:\PWR\Obrazki\Projekt\Banknoty\10zlfoto\10_base_back.jpg');
    global ref_img_20_front;
    ref_img_20_front = imread('D:\PWR\Obrazki\Projekt\Banknoty\20z³foto\20_base_front.jpg');
    global ref_img_20_back;
    ref_img_20_back = imread('D:\PWR\Obrazki\Projekt\Banknoty\20z³foto\20_base_back.jpg');
    global ref_img_50_front
    ref_img_50_front = imread('D:\PWR\Obrazki\Projekt\Banknoty\50z³foto\50_base_front.jpg');
    global ref_img_50_back;
    ref_img_50_back = imread('D:\PWR\Obrazki\Projekt\Banknoty\50z³foto\50_base_back.jpg');
    global ref_img_100_front;
    ref_img_100_front = imread('D:\PWR\Obrazki\Projekt\Banknoty\100z³foto\100_base_front.jpg');
    global ref_img_100_back;
    ref_img_100_back = imread('D:\PWR\Obrazki\Projekt\Banknoty\100z³foto\100_base_back.jpg');
    global ref_img_200_front;
    ref_img_200_front = imread('D:\PWR\Obrazki\Projekt\Banknoty\200z³foto\200_base_front.jpg');
    global ref_img_200_back;
    ref_img_200_back = imread('D:\PWR\Obrazki\Projekt\Banknoty\200z³foto\200_base_back.jpg');

    global ref_images;
    ref_images = {ref_img_10_front,ref_img_20_front,ref_img_50_front,ref_img_100_front,ref_img_200_front};

[file,path] = uigetfile({'*.*'});
img_location = fullfile(path, file);
[dopasowane_punkty_na_zdjeciu_wczytanym, dopasowane_punkty_na_zdjeciu_bazowym, banknot]=sprawdzanie_banknotu(img_location);

axes(handles.axes1);
showMatchedFeatures(imread(img_location), cell2mat(ref_images(banknot)), dopasowane_punkty_na_zdjeciu_wczytanym, ...
dopasowane_punkty_na_zdjeciu_bazowym, 'montage');
title('Pary punktów charakterystycznych');
legend('Pasujace punkty na zdjêciu bazowym','Pasujace punkty na zdjêciu wczytanym');
set(handles.kraj, 'String','Polska')
set(handles.waluta, 'String','Z³oty')
set(handles.nominal,'String',checkIndex(banknot));


function nominal_Callback(hObject, eventdata, handles)
% hObject    handle to nominal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nominal as text
%        str2double(get(hObject,'String')) returns contents of nominal as a double


% --- Executes during object creation, after setting all properties.
function nominal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nominal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kraj_Callback(hObject, eventdata, handles)
% hObject    handle to kraj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kraj as text
%        str2double(get(hObject,'String')) returns contents of kraj as a double


% --- Executes during object creation, after setting all properties.
function kraj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kraj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function waluta_Callback(hObject, eventdata, handles)
% hObject    handle to waluta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of waluta as text
%        str2double(get(hObject,'String')) returns contents of waluta as a double


% --- Executes during object creation, after setting all properties.
function waluta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to waluta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
