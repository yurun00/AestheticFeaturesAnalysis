clear all; clc;
imgfile = 'horse-viol-1874';
addr_clsm = ['..\..\..\data\features\classeme\features_genre\',imgfile,'_classemes.mat'];
addr_key = '..\..\..\vlg_extractor_1.1.3\classeme_keywords.txt';


key_words = cell(2659,1);
i = 1;
fid = fopen(addr_key);
tline = fgets(fid);
while ischar(tline)
    disp(tline);
    idc = regexp(tline,['\d']);
    key_words{i} = tline(1:idc(1)-1);
    tline = fgets(fid);
    i = i+1;
end
fclose(fid);

load(addr_clsm);
[B,I] = sort(classemes,'descend');
I = I(1:10);

keys = key_words(I(1:10));