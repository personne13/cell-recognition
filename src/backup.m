map = [0 0 0.3
    0 0.4 0
    0 0 0.5
    0 0 0.6
    0.8 0 0
    0 0 1.0
    0.2 0 0
    0 1.0 1.0];
    [label_im, vec_mean] = kmeans_fast_Color(handles.CurrentRGBImage,8);
    imshow(label_im, map, 'Parent',handles.AxesMainCanvas);