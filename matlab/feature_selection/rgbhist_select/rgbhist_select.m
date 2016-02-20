%% DESCRIPTION:
% The program selects features from RGB histogram, in which each interval 
% of color space represents a feature. It is related to the topic on how to
% select features for classifying high-dimensional data. It performs
% sequential feature selection, which is one of the most popular feature
% selection algorithms and uses holdout and cross-validation to evaluate 
% the performance of the selected features.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: cvsequentialfsdemo.m(matlab command 'edit cvsequentialfsdemo')

% Author: Run Yu, undergraduate, computer science
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn
% Website: none
% Created: 02/17/2016; Last revision: 02/18/2016

%------------- BEGIN CODE --------------

clear all; %clc;

%% Loading the data
% This part focus on the paintings belong to the category 'landscape' and 
% 'portrait' to find the differences between them.
%
% The data set mainly has two variables |obs| and |grp|. The |obs| variable
% consists observations with 512 features. Each element in |grp| defines 
% the group to which the corresponding row of |obs| belongs.

addr_ls_ftr = '..\..\..\data\features\rgb_hist\genre\landscape\';
addr_ptt_ftr = '..\..\..\data\features\rgb_hist\genre\portrait\';
rgbhist_mat_ls = dir(fullfile(addr_ls_ftr,'*.mat'));
rgbhist_mat_ptt = dir(fullfile(addr_ptt_ftr,'*.mat'));

% Store the category of corresponding painting's histogram, 
grp = cell(length(rgbhist_mat_ls) + length(rgbhist_mat_ptt), 1);
addi = 0;

% RGB histogram matrix of landscape images
rgbhist_ls = zeros(length(rgbhist_mat_ls), 512);
for i=1:length(rgbhist_mat_ls)
        name_len = strfind(rgbhist_mat_ls(i).name,'.mat')-1;
        
        %Load rgbhist
        rgbhist_in = load(strcat(addr_ls_ftr,rgbhist_mat_ls(i).name));
        rgbhist_in = rgbhist_in.rgbhist;
        
        %Concatenate the rgbhist
        rgbhist_ls(i,:) = rgbhist_in';
        
        grp{i+addi} = 'landscape';
end
addi = addi + length(rgbhist_mat_ls);

%RGB histogram matrix of portrait images
rgbhist_ptt = zeros(length(rgbhist_mat_ptt), 512);
for i=1:length(rgbhist_mat_ptt)
        name_len = strfind(rgbhist_mat_ptt(i).name,'.mat')-1;
        
        %Load rgbhist
        rgbhist_in = load(strcat(addr_ptt_ftr,rgbhist_mat_ptt(i).name));
        rgbhist_in = rgbhist_in.rgbhist;
        
        %Concatenate the rgbhist
        rgbhist_ptt(i,:) = rgbhist_in';
        
        grp{i+addi} = 'portrait';
end
addi = addi + length(rgbhist_mat_ptt);

obs = [rgbhist_ls;rgbhist_ptt];

%% Dividing Data Into a Training Set and a Test Set 
% Use |cvpartition| to divide data into a training set and a test set. Both
% the training set and the test set have roughly the same group proportions
% as in |grp|. One often select features using the training data and judge 
% the performance of the selected features on the test data, which is often 
% called holdout validation.

holdoutCVP = cvpartition(grp,'holdout',0.2);
%%
dataTrain = obs(holdoutCVP.training,:);
grpTrain = grp(holdoutCVP.training);

%% The Problem of Classifying Data Using All the Features
% Without first reducing the number of features, some classification
% algorithms would fail on the data set, since the number of features is 
% much larger than the number of observations.
%
% If one use Quadratic Discriminant Analysis (QDA) as the classification
% algorithm and apply QDA on the data using all the features, he will get 
% an error because there are not enough samples in each group to estimate a
% covariance matrix. 

% try
%    yhat = classify(obs(test(holdoutCVP),:), dataTrain, grpTrain,'quadratic');
% catch ME
%    display(ME.message);
% end

%% Selecting Features Using a Simple Filter Approach
% The goal is to reduce the dimension of the data by finding a small set of
% important features. One can apply fileter methods as pre-processing step.
%
% Feature selection algorithms can be roughly grouped into two categories:
% filter methods and wrapper methods. Filter methods rely on general
% characteristics of the data to evaluate and to select the feature subsets
% without involving the chosen learning algorithm (QDA in this example).
% Wrapper methods use the performance of the chosen learning algorithm to
% evaluate each candidate feature subset. Wrapper methods search for
% features better fit for the chosen learning algorithm, but they can be
% significantly slower than filter methods if the learning algorithm takes
% a long time to run.
%
% Filters are usually used as a pre-processing step since they are simple
% and fast. A widely-used filter method for bioinformatics data is to apply
% a univariate criterion separately on each feature, assuming that there is
% no interaction between features. 
%
% We apply the _t_-test on each feature and compare _p_-value (or the 
% absolute values of _t_-statistics) for each feature as a measure of how 
% effective it is at separating groups.
dataTrainG1 = dataTrain(grp2idx(grpTrain)==1,:);
dataTrainG2 = dataTrain(grp2idx(grpTrain)==2,:);
[h,p,ci,stat] = ttest2(dataTrainG1,dataTrainG2,'Vartype','unequal');
%%
%Plot the empirical cumulative distribution function(CDF) of the _p_-values
ecdf(p);
xlabel('P value'); 
ylabel('CDF value');

%%
% There are about 30% of features having _p_-values close to zero, meaning 
% there are more than 150 features among the original 512 features that 
% have strong discrimination power. One can sort these features according 
% to their _p_-values (or the absolute values of the _t_-statistic) and 
% select some features from the sorted list. But one should decide how many
% features are needed.
%
% One quick way to decide the number of needed features is to plot the MCE
% (misclassification error, i.e., the number of misclassified observations
% divided by the number of observations) on the test set as a function of
% the number of features. Since there are only 512 featrues in the
% training set, the largest number of features for applying QDA is limited,
%
% Now we compute MCE for various numbers of features between 10 and 510 and
% show the plot of MCE as a function of the number of features. In order to
% reasonably estimate the performance of the selected model, it is
% important to use the 80% training samples to fit the QDA model and
% compute the MCE on the 20% test observations (blue circular marks in the
% following plot). To illustrate why resubstitution error is not a good
% error estimate of the test error, we also show the resubstitution MCE
% using red triangular marks.
%
[~,featureIdxSortbyP] = sort(p,2); % sort the features
testMCE = zeros(1,51);
resubMCE = zeros(1,51);
nfs = 10:10:510;
classf = @(xtrain,ytrain,xtest,ytest) ...
             sum(~strcmp(ytest,classify(xtest,xtrain,ytrain,'quadratic')));
resubCVP = cvpartition(length(grp),'resubstitution');
for i = 1:51
   fs = featureIdxSortbyP(1:nfs(i));
   testMCE(i) = crossval(classf,obs(:,fs),grp,'partition',holdoutCVP)...
       /holdoutCVP.TestSize;
   resubMCE(i) = crossval(classf,obs(:,fs),grp,'partition',resubCVP)/...
       resubCVP.TestSize;
end
 plot(nfs, testMCE,'o',nfs,resubMCE,'r^');
 xlabel('Number of Features');
 ylabel('MCE');
 legend({'MCE on the test set' 'Resubstitution MCE'},'location','NW');
 title('Simple Filter Feature Selection Method');

%------------- END OF CODE --------------