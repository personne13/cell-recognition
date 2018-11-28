function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
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
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 28-Nov-2018 14:25:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in FileDropDown.
function FileDropDown_Callback(hObject, eventdata, handles)
% hObject    handle to FileDropDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FileDropDown contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FileDropDown

cla(handles.AxesMainCanvas);

if isfield(handles, 'CurrentRGBImage')
    handles = rmfield(handles, 'CurrentRGBImage');
    % Update handles structure
    guidata(hObject, handles);
end

if isfield(handles, 'CurrentLABImage')
    handles = rmfield(handles, 'CurrentLABImage');
    % Update handles structure
    guidata(hObject, handles);
end

if isfield(handles, 'CurrentNDGImage')
    handles = rmfield(handles, 'CurrentNDGImage');
    % Update handles structure
    guidata(hObject, handles);
end

if isfield(handles, 'CurrentBinaryImage')
    handles = rmfield(handles, 'CurrentBinaryImage');
    % Update handles structure
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function FileDropDown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileDropDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenFolderItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFolderItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dirpath = uigetdir('.');
files = dir(fullfile(dirpath, '*.tif'));

if isempty(files)
    f = msgbox('No ttf file in folder');
    return
end

handles.FileDropDown.String = {files.name};
handles.OpenedFolder = dirpath;

% Update handles structure
guidata(hObject, handles);


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ShowRGBFeature.
function ShowRGBFeature_Callback(hObject, eventdata, handles)
% hObject    handle to ShowRGBFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'OpenedFolder')
    if ~isfield(handles, 'CurrentRGBImage')
        fileName = handles.FileDropDown.String(handles.FileDropDown.Value);
        handles.CurrentRGBImage = imread(strcat(handles.OpenedFolder,'/', fileName{1}));
    end
    imshow(handles.CurrentRGBImage, 'Parent',handles.AxesMainCanvas);
else
    f = msgbox('No folder loaded yet');
    return
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in ShowNDGFeature.
function ShowNDGFeature_Callback(hObject, eventdata, handles)
% hObject    handle to ShowNDGFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isfield(handles, 'CurrentNDGImage')
    if isfield(handles,'OpenedFolder')
        if ~isfield(handles, 'CurrentRGBImage')
            fileName = handles.FileDropDown.String(handles.FileDropDown.Value);
            handles.CurrentRGBImage = imread(strcat(handles.OpenedFolder,'/', fileName{1}));
        end
        handles.CurrentNDGImage = rgb2gray(handles.CurrentRGBImage);
    else
        f = msgbox('No folder loaded yet');
        return
    end
end

% Update handles structure
guidata(hObject, handles);

imshow(handles.CurrentNDGImage, 'Parent',handles.AxesMainCanvas);



% --- Executes on button press in ShowLABFeature.
function ShowLABFeature_Callback(hObject, eventdata, handles)
% hObject    handle to ShowLABFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isfield(handles, 'CurrentLABImage')
    if isfield(handles,'OpenedFolder')
        if ~isfield(handles, 'CurrentLABImage')
            fileName = handles.FileDropDown.String(handles.FileDropDown.Value);
            handles.CurrentRGBImage = imread(strcat(handles.OpenedFolder,'/', fileName{1}));
        end
        handles.CurrentLABImage = rgb2lab(handles.CurrentRGBImage);
    else
        f = msgbox('No folder loaded yet');
        return
    end
end

% Update handles structure
guidata(hObject, handles);

imshow(handles.CurrentLABImage, 'Parent',handles.AxesMainCanvas);


% --- Executes on button press in ConvertBinaryFeature.
function ConvertBinaryFeature_Callback(hObject, eventdata, handles)
% hObject    handle to ConvertBinaryFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if isfield(handles,'OpenedFolder')
    if ~isfield(handles, 'CurrentRGBImage')
        fileName = handles.FileDropDown.String(handles.FileDropDown.Value);
        handles.CurrentRGBImage = imread(strcat(handles.OpenedFolder,'/', fileName{1}));
    end
    prompt = {'Enter a binary threshold'};
    title = 'Value';
    definput = {'0.5'};
    opts.Interpreter = 'tex';
    thresholdValue = -1;
    while(thresholdValue < 0 || thresholdValue > 1)
        thresholdValue = inputdlg(prompt,title,[1 40],definput,opts);
        if isempty(thresholdValue)
            return 
        end
        thresholdValue = str2num(thresholdValue{1});
        
        if(thresholdValue < 0 || thresholdValue > 1)
            msgbox('Value must be between 0 and 1');
        end
    end

    handles.CurrentBinaryImage = im2bw(handles.CurrentRGBImage, thresholdValue);
else
    f = msgbox('No folder loaded yet');
    return
end

% Update handles structure
guidata(hObject, handles);

imshow(handles.CurrentBinaryImage, 'Parent',handles.AxesMainCanvas);
