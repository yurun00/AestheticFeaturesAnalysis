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
Bs1 = [];
Bs2 = [];
Bs3 = [];
for j = 1:length(genres)
    g = genres{j};
    fids = paintings_by_genre(g);
    cls = [];
    for i = 1:length(fids)
        load([addr_fts,'features_genre\',fids{i},'_classemes.mat']);
        cls = [cls;classemes'];
    end
    s = sum(cls);
    [B,I] = sort(s,'descend');
    Bs1 = [Bs1,B'];
    Bs2 = [Bs2,B(1:300)'];
    Bs3 = [Bs3,B(1500:2500)'];
end

f1 = figure(1);
set(f1, 'Position',  [100,100,1200,400]);

subplot(1,3,1);
p1 = plot(Bs1);
title(['Weights of most weighted classemes in genres']);
legend(genres);

subplot(1,3,2);
p2 = plot(Bs2);
title(['Weights of most weighted classemes in genres']);
legend(genres);

subplot(1,3,3);
p3 = plot(Bs3);
title(['Weights of most weighted classemes in genres']);
legend(genres);
ax = gca;
ax.XTick = 0:200:1000;
ax.XTickLabel = 1500:200:2500;

%------------- END OF CODE --------------