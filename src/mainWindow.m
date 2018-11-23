global mainWindow;
global widthWindow;
global heightWindow;
widthWindow = 1080;
heightWindow = 620;

mainWindow = uifigure('Position', [100, 30, widthWindow, heightWindow]);
m = uimenu(mainWindow,'Text','File');
mitem = uimenu(m,'Text','Open folder', 'Callback',@callback_openFolder);

function callback_openFolder(src,evt)
global mainWindow;
global widthWindow;
global heightWindow;
dirpath = uigetdir('.');
files = dir(dirpath);
files.name
p = uipanel(mainWindow,'Position',[20 20 100 (heightWindow - 60)]);
end

