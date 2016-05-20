% DESCRIPTION: The extracted classeme features of all paintings are 
% compared by genres.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_genre.mat
%   ..\..\data\features\classeme\features_genre\*_classemes.mat
%   ..\..\data\results\genre\classeme_f1_measure.mat

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_fts = '..\..\data\features\classeme\';
addr_rst = '..\..\data\results\';
addr_key = '..\..\vlg_extractor_1.1.3\classeme_keywords.txt';

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

paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;
% paintings = paintings_by_genre.values;
% paintings = [paintings{:}];
genres = paintings_by_genre.keys;
g = genres{2};
fids = paintings_by_genre(g);
cls = zeros(1,2659);
for i = 1:length(fids)
    load([addr_fts,'features_genre\',fids{i},'_classemes.mat']);
    [B,I] = sort(classemes','descend');
    I = I(1:10);
    cls(I) = cls(I)+1;
end

[B,I] = sort(cls,'descend');
B = B(1:10);
I = I(1:10);

f1 = figure(1);
set(f1, 'Position',  [100,100,1200,500]);
p1 = plot(B);

title(['Most weighted classemes of genre ',g]);
xlabel('classemes');
ax = gca;
ax.XTick = 1:10;
ax.XTickLabel = key_words(I);

%------------- END OF CODE --------------