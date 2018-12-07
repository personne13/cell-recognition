function data = data_extractor(labels)
    data = [];
    size_neighbors = 5;
    for i = 1:length(labels)
    
        mask = createMask(labels(i).poly);
        c1 = labels(i).image(:,:,1);
        c2 = labels(i).image(:,:,2);
        c3 = labels(i).image(:,:,3);
        
        [m, n] = size(c1);
        mat_mean_c1 = zeros(m, n);
        mat_mean_c2 = zeros(m, n);
        mat_mean_c3 = zeros(m, n);
        
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
        
        c1(mask==0)=0;
        c2(mask==0)=0;
        c3(mask==0)=0;
        pix_c1=c1(mask==1);
        pix_c2=c2(mask==1);
        pix_c3=c3(mask==1);
        
        mean_c1 = mat_mean_c1(mask==1);
        mean_c2 = mat_mean_c2(mask==1);
        mean_c3 = mat_mean_c3(mask==1);
       
        
        lab=ones(length(pix_c1),1)*labels(i).type;
        
        newdata = [];
        newdata = [newdata, lab];
        newdata = [newdata, pix_c1];
        newdata = [newdata, pix_c2];
        newdata = [newdata, pix_c3];
        newdata = [newdata, mean_c1];
        newdata = [newdata, mean_c2];
        newdata = [newdata, mean_c3];
        
        data = [data; newdata];
    end
end