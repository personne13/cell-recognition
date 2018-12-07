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

% Last Modified by GUIDE v2.5 05-Dec-2018 17:18:16

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

if isfield(handles, 'Labels')
    handles = rmfield(handles, 'Labels');
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

if dirpath == 0
   return 
end

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
        handles.CurrentRGBImage = imresize(handles.CurrentRGBImage, 0.25);
    end
    imshow(handles.CurrentRGBImage, 'Parent',handles.AxesMainCanvas);
    if isfield(handles, 'Labels')
        handles = rmfield(handles, 'Labels');
        % Update handles structure
        guidata(hObject, handles);
    end
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
        thresholdValue = str2double(thresholdValue{1});
        
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


% --- Executes on button press in convertKmeansFeature.
function convertKmeansFeature_Callback(hObject, eventdata, handles)
% hObject    handle to convertKmeansFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'OpenedFolder')
    if ~isfield(handles, 'CurrentRGBImage')
        fileName = handles.FileDropDown.String(handles.FileDropDown.Value);
        handles.CurrentRGBImage = imread(strcat(handles.OpenedFolder,'/', fileName{1}));
    end
    prompt = {'Enter the number of clusters'};
    title = 'Value';
    definput = {'3'};
    opts.Interpreter = 'tex';
    k = -1;
    while(k < 1 || k > 8)
        k = inputdlg(prompt,title,[1 40],definput,opts);
        if isempty(k)
            return 
        end
        k = str2num(k{1});
        
        if(k < 1 || k > 8)
            msgbox('Value must be between 1 and 8');
        end
    end
    map = computeColorMapKmeans(k);
    [label_im, vec_mean] = kmeans_fast_Color(handles.CurrentRGBImage,k);
    imshow(label_im, map, 'Parent',handles.AxesMainCanvas);
else
    f = msgbox('No folder loaded yet');
    return
end

% Update handles structure
guidata(hObject, handles);

function colormap = computeColorMapKmeans(k)
colormap = zeros(k,3);
for i=1:k
    colormap(3*(i-1) + 1 :3*(i-1)+3) = [0 0 i/k];
end


% --- Executes on button press in LabelEditionFeature.
function LabelEditionFeature_Callback(hObject, eventdata, handles)
% hObject    handle to LabelEditionFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isfield(handles, 'CurrentRGBImage')
    msgbox('Open an rgb image before adding a label');
    return
end

currentPoly = impoly(handles.AxesMainCanvas);

switch (handles.ChangeLabelFeature.Value)
    case 1
        setColor(currentPoly, 'green');
    case 2
        setColor(currentPoly, 'black');
    case 3
        setColor(currentPoly, 'red');
    case 4
        setColor(currentPoly, 'yellow');
end

label.poly = currentPoly;
label.type = handles.ChangeLabelFeature.Value;
label.image = handles.CurrentRGBImage;

if ~isfield(handles, 'Labels')
    handles.Labels = label;
else
    handles.Labels = [handles.Labels label];
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in PredictFeature.
function PredictFeature_Callback(hObject, eventdata, handles)
% hObject    handle to PredictFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isfield(handles, 'CurrentRGBImage')
    msgbox('No loaded image');
    return
end

if ~isfield(handles, 'TrainedModel')
    msgbox('Train a model before predicting');
    return
end

%Creating features ...
c1 = handles.CurrentRGBImage(:,:,1);
c2 = handles.CurrentRGBImage(:,:,2);
c3 = handles.CurrentRGBImage(:,:,3);

[m, n] = size(c1);
mat_mean_c1 = zeros(m, n);
mat_mean_c2 = zeros(m, n);
mat_mean_c3 = zeros(m, n);

size_neighbors = 5;

for row = 1:m
    for col = 1:n
        i0 = max(row-size_neighbors, 1);
        i1 = min(row+size_neighbors, m);
        j0 = max(col-size_neighbors, 1);
        j1 = min(col+size_neighbors, n);
        sub_mat = c1(i0:i1,j0:j1);
        mat_mean_c1(row,col) = sum(sum(sub_mat) / ((i1 - i0 + 1) * (j1 - j0 + 1)));

        sub_mat = c2(i0:i1,j0:j1);
        mat_mean_c2(row,col) = sum(sum(sub_mat) / ((i1 - i0 + 1) * (j1 - j0 + 1)));

        sub_mat = c3(i0:i1,j0:j1);
        mat_mean_c3(row,col) = sum(sum(sub_mat) / ((i1 - i0 + 1) * (j1 - j0 + 1)));
    end
end

mat_sd_c1 = zeros(m, n);
mat_sd_c2 = zeros(m, n);
mat_sd_c3 = zeros(m, n);

for row = 1:m
    for col = 1:n
        i0 = max(row-size_neighbors, 1);
        i1 = min(row+size_neighbors, m);
        j0 = max(col-size_neighbors, 1);
        j1 = min(col+size_neighbors, n);
        sub_mat = c1(i0:i1,j0:j1);
        mat_sd_c1(row,col) = sum(sum(sub_mat - mat_mean_c1(row,col)) / ((i1 - i0 + 1) * (j1 - j0 + 1)));

        sub_mat = c2(i0:i1,j0:j1);
        mat_sd_c2(row,col) = sum(sum(sub_mat - mat_mean_c2(row,col)) / ((i1 - i0 + 1) * (j1 - j0 + 1)));

        sub_mat = c3(i0:i1,j0:j1);
        mat_sd_c3(row,col) = sum(sum(sub_mat - mat_mean_c3(row,col)) / ((i1 - i0 + 1) * (j1 - j0 + 1)));
    end
end

unknown_data = [];
unknown_data = [unknown_data, c1(:)];
unknown_data = [unknown_data, c2(:)];
unknown_data = [unknown_data, c3(:)];

unknown_data = [unknown_data, mat_mean_c1(:)];
unknown_data = [unknown_data, mat_mean_c2(:)];
unknown_data = [unknown_data, mat_mean_c3(:)];

unknown_data = [unknown_data, mat_sd_c1(:)];
unknown_data = [unknown_data, mat_sd_c2(:)];
unknown_data = [unknown_data, mat_sd_c3(:)];

unknown_data = double(unknown_data);

nbPx = length(unknown_data);
m = msgbox('Model predicting...');
[predicted_label] = svmpredict(ones(nbPx,1), unknown_data, handles.TrainedModel);
m.delete();

label_im = reshape(predicted_label, size(c1));
map = computeColorMapKmeans(4);
imshow(label_im, map, 'Parent',handles.AxesMainCanvas);

% --- Executes on button press in pushbutton9.
function TrainFeature_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'data')
    msgbox('No existing data');
    return
end


[m, np1] = size(handles.data);
n = np1 - 1;
training_label_vector = double(handles.data(1:m,1:1));
training_instance_matrix = double(handles.data(1:m, 2:np1));

m = msgbox('Model training...');

handles.TrainedModel = svmtrain(training_label_vector, training_instance_matrix, '-t 2 -c 100 -h 0');

msgbox('Model trained');
m.delete();

% Update handles structure
guidata(hObject, handles);



% --- Executes on selection change in ChangeLabelFeature.
function ChangeLabelFeature_Callback(hObject, eventdata, handles)
% hObject    handle to ChangeLabelFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ChangeLabelFeature contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ChangeLabelFeature


% --- Executes during object creation, after setting all properties.
function ChangeLabelFeature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChangeLabelFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveLabelFeature.
function SaveLabelFeature_Callback(hObject, eventdata, handles)
% hObject    handle to SaveLabelFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isfield(handles, 'Labels')
    msgbox('No label on current image');
    return
end

new_data = data_extractor(handles.Labels);

if ~isfield(handles, 'data')
    handles.data = new_data;
else
    handles.data = [handles.data;new_data];
end


for i = 1:length( handles.Labels)
    handles.Labels(i).poly.delete();
end

handles = rmfield(handles, 'Labels');
% Update handles structure
guidata(hObject, handles);

