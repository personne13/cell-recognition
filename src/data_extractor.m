function data = data_extractor(labels)
    data = [];
    for i = 1:length(labels)
    
        mask = createMask(labels(i).poly);
        c1 = labels(i).image(:,:,1);
        c2 = labels(i).image(:,:,2);
        c3 = labels(i).image(:,:,3);
        c1(mask==0)=0;
        c2(mask==0)=0;
        c3(mask==0)=0;
        pix_c1=c1(mask==1);
        pix_c2=c2(mask==1);
        pix_c3=c3(mask==1);
        lab=ones(length(pix_c1),1)*labels(i).type;
        
        newdata = [];
        newdata = [newdata, lab];
        newdata = [newdata, pix_c1];
        newdata = [newdata, pix_c2];
        newdata = [newdata, pix_c3];
        
        data = [data; newdata];
    end
end