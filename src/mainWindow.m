global mainWindow;
global dropDown;
global dirpath;
global loadedDir;
global mainCanvas;
global currentImage;
widthWindow = 1080;
heightWindow = 620;
loadedDir = false;

mainWindow = uifigure('Position', [100, 30, widthWindow, heightWindow], 'Resize', 'off');
windowDimensions = get(mainWindow, 'Position');
m = uimenu(mainWindow,'Text','File');
mitem = uimenu(m,'Text','Open folder', 'Callback',@callback_openFolder);
featurePanel = uipanel(mainWindow,'Position',[20 20 100 (windowDimensions(4) - 60)]);
panelDimensions = get(featurePanel, 'Position');
buttonShow = uibutton(featurePanel,...
                      'Text', 'show',...
                      'Position', [0 (panelDimensions(4) - 21) 100 20],...
                      'ButtonPushedFcn', @(buttonShow, event)callBack_showImg(buttonShow));
                  
mainCanvas = uipanel(mainWindow,'Position',[(panelDimensions(1) + panelDimensions(3) + 20) 20 800 (windowDimensions(4) - 60)]);
%mainCanvas = axes(mainWindow);

%TODO: fonction show

function callback_openFolder(src,evt)
global mainWindow;
windowDimensions = get(mainWindow, 'Position');
global dropDown;
global dirpath;
global loadedDir;

dirpath = uigetdir('.');
files = dir(fullfile(dirpath, '*.tif'));

dropDown = uidropdown(mainWindow, 'Items',{files.name},'Value', files(1).name,'Position',[20 (windowDimensions(4) - 30) 140 20]);
loadedDir = true;

end

function callBack_showImg(src)
global dropDown;
global dirpath;
global loadedDir;
global mainCanvas;
global currentImage;

if loadedDir
    file = get(dropDown, 'Value');
    currentImage = imread(strcat(dirpath,'/', file));
    imshow(currentImage,'Parent',app.image_view);
else
    f = msgbox('No folder loaded yet');
end

end
