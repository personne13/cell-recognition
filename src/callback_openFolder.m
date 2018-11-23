function callback_openFolder(src,evt)
global mainWindow;
global widthWindow;
global heightWindow;
dirpath = uigetdir('.');
files = dir(dirpath);
files.name
p = uipanel(mainWindow,'Position',[20 20 100 (heightWindow - 60)]);
end

