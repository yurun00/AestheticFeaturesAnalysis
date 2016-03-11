
for k = 3 : 3
    mydir=['D:\matlabworkspace\data\',num2str(k)];
    addpath(mydir);

    count1 = 269;
    postfix = '.bmp'
    file1 = ['coarseness', num2str(k), '.txt'];
    file2 = ['directionality', num2str(k), '.txt'];
    file3 = ['contrast', num2str(k), '.txt'];
    fid = fopen(file1, 'w');
    fid1 = fopen(file2, 'w');
    fid2 = fopen(file3, 'w');
    offsets0 = [zeros(40, 1), (1:40)'];

    for i = 0 : count1
        name = 'firlayer';
        dst = [name, num2str(i), postfix];
        dstg = imread(dst);
        CoaFeatures = coarseness(double(dstg));
        DirFeatures = min([directionality(double(dstg)),directionality(double(imrotate(dstg,45,'bilinear','crop'))),directionality(double(imrotate(dstg,90,'bilinear','crop'))),directionality(double(imrotate(dstg,-45,'bilinear','crop')))]);
        Contrasts = contrast(double(dstg));
        fprintf(fid, '%.4f\n', CoaFeatures);
        fprintf(fid1, '%.4f\n', DirFeatures);
        fprintf(fid2, '%.4f\n', Contrasts);
        glcms = graycomatrix(dstg, 'Offset', offsets0);
        stats = graycoprops(glcms,'Contrast Correlation Energy Homogeneity');
        disp(i);
    end
%fclose(file1);
%fclose(file2);
end
