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
% Created: 02/17/2016; Last revision: 02/22/2016

%------------- BEGIN CODE --------------

clear all; clc;

%% Loading the data
% This part focus on the paintings belong to the category 'landscape' and 
% 'portrait' to find the differences between them.
%
% The data set mainly has two variables |obs| and |grp|. The |obs| variable
% consists observations with 512 features. Each element in |grp| defines 
% the group to which the corresponding row of |obs| belongs.

addr = '..\..\..\data\features\rgb_hist\genre\';
ls = 'landscape';
ptt = 'portrait';
addr_ls_ftr = strcat(addr,ls,'\');
addr_ptt_ftr = strcat(addr,ptt,'\');
rgbhist_mat_ls = dir(fullfile(addr_ls_ftr,'*.mat'));
rgbhist_mat_ptt = dir(fullfile(addr_ptt_ftr,'*.mat'));

% Store the category of corresponding painting's histogram
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
% as in |grp|. I apply holdout validation here.

holdoutCVP = cvpartition(grp,'holdout',0.2);
%%
dataTrain = obs(holdoutCVP.training,:);
grpTrain = grp(holdoutCVP.training);

%% The Problem of Classifying Data Using All the Features
% If one uses Quadratic Discriminant Analysis (QDA) as the classification
% algorithm and applies QDA on the data using all the features, he will get 
% an error here because there are not enough samples in each group to 
% estimate a covariance matrix. 
%
% In this case, there is an error for the lack of samples.

try
   yhat = classify(obs(test(holdoutCVP),:), dataTrain, grpTrain,'quadratic');
catch ME
   display(ME.message);
end

%% Selecting Features Using a Simple Filter Approach
% Apply fileter methods as pre-processing step first.
%
% Apply Wrapper methods latter to search for features better fit for the 
% chosen learning algorithm, becasue they can be significantly slower.
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
% Plot the MCE on the test set as a function of the number of features to 
% decide the number of needed features.
% (misclassification error, i.e., the number of misclassified observations
% divided by the number of observations) 
%
% Use the 80% training samples to fit the QDA model and compute the MCE on 
% the 20% test observations (blue circular marks in the following plot). 
% Also show the resubstitution MCE using red triangular marks.
%
[~,featureIdxSortbyP] = sort(p,2); % sort the features
% testMCE = zeros(1,51);
% resubMCE = zeros(1,51);
testMCE = zeros(1,20);
resubMCE = zeros(1,20);
% nfs = 10:10:510;
nfs = 10:10:200;
% For convenience, |classf| is defined as an anonymous function. It fits
% QDA on the given training set and returns the number of misclassified
% samples for the given test set. If one wanted to develop his own
% classification algorithm, he might want to put it in a separate file, as
% follows:

%  function err = classf(xtrain,ytrain,xtest,ytest)
%       yfit = classify(xtest,xtrain,ytrain,'quadratic');
%        err = sum(~strcmp(ytest,yfit));
classf = @(xtrain,ytrain,xtest,ytest) ...
             sum(~strcmp(ytest,classify(xtest,xtrain,ytrain,'quadratic')));
resubCVP = cvpartition(length(grp),'resubstitution');
% The maximum number of features cannot be greater than 200. With more 
% features,the Quadratic Discriminant Analysis (QDA) will get an error 
% because there are not enough samples in each group to estimate a 
% covariance matrix. 
% for i = 1:51
for i = 1:20
   fs = featureIdxSortbyP(1:nfs(i));
   testMCE(i) = crossval(classf,obs(:,fs),grp,'partition',holdoutCVP)...
       /holdoutCVP.TestSize;
   resubMCE(i) = crossval(classf,obs(:,fs),grp,'partition',resubCVP)/...
       resubCVP.TestSize;
end
save(strcat(addr,'_f_sel_mce\',ls,'_',ptt,'_testMCE.mat'),'testMCE');
save(strcat(addr,'_f_sel_mce\',ls,'_',ptt,'_resubMCE.mat'),'resubMCE');
plot(nfs, testMCE,'o',nfs,resubMCE,'r^');
xlabel('Number of Features');
ylabel('MCE');
legend({'MCE on the test set' 'Resubstitution MCE'},'location','NW');
title('Simple Filter Feature Selection Method');
%%
% This simple filter feature selection method gets the smallest MCE on the 
% test set when 160 features are used. The smallest MCE on the test set is 
% about 22%:
testMCE(16);
%%
% These are the first 160 features that achieve the minimum MCE:
featureIdxSortbyP(1:160);

%% Applying Sequential Feature Selection
% Considering interaction between features and redundant information, one
% may apply SFS.
%
% The feature selection procedure performs a sequential search using the 
% MCE of the learning algorithm QDA on each candidate feature subset 
% as the performance indicator for that subset.
% 
% The training set is used to select the features and to fit the QDA model,
% and the test set is used to evaluate the performance of the finally 
% selected features. During the feature selection procedure, to evaluate 
% and to compare the performance of the each candidate feature subset, we 
% apply stratified 10-fold cross-validation to the training set.
%
% Generate a stratified 10-fold partition for the training set
tenfoldCVP = cvpartition(grpTrain,'kfold',10);
%%
% Use the filter results from the previous section as a pre-processing step
% to select features. For instance, we select 160 features here:
fs1 = featureIdxSortbyP(1:160);
%%
% We apply forward sequential feature selection on these 160 features.
% The function |sequentialfs| stops when the first local minimum of the 
% cross-validation MCE is found.
fsLocal = sequentialfs(classf,dataTrain(:,fs1),grpTrain,'cv',tenfoldCVP);
%%
% The selected features are the following:
fs1(fsLocal);

%%
% To evaluate the performance of the selected model with these 12 features,
% we compute the MCE on the 56 test samples.
testMCELocal = crossval(classf,obs(:,fs1(fsLocal)),grp,'partition',...
    holdoutCVP)/holdoutCVP.TestSize;
%% 
% With only 12 features being selected, the MCE is a little over the 
% smallest MCE using the simple filter feature selection method.

%%
% The algorithm may have stopped prematurely. Sometimes a smaller MCE is
% achievable by looking for the minimum of the cross-validation MCE over a
% reasonable range of number of features. 
% Draw the plot of the cross-validation MCE as a function of the number of 
% features for up to 50 features.
[fsCVfor100,historyCV] = sequentialfs(classf,dataTrain(:,fs1),grpTrain,...
    'cv',tenfoldCVP,'Nf',100);
fsfsMCE = historyCV.Crit;
save(strcat(addr,'_f_sel_mce\',ls,'_',ptt,'_fsfsMCE.mat'),'fsfsMCE');
plot(historyCV.Crit,'o');
xlabel('Number of Features');
ylabel('CV MCE');
title('Forward Sequential Feature Selection with cross-validation');
%%
% The cross-validation MCE reaches the minimum when 51 features are used.
fsCVfor51 = fs1(historyCV.In(51,:));
%% 
% To show these 51 features in the order in which they are selected in the
% sequential forward procedure, we find the row in which they first become
% true in the |historyCV| output:
[orderlist,ignore] = find( [historyCV.In(1,:); diff(historyCV.In(1:51,:) )]' );
fs1(orderlist)
%%
% To evaluate these 10 features, we compute their MCE for QDA on the test
% set. We get the smallest MCE value so far:
testMCECVfor51 = crossval(classf,obs(:,fsCVfor51),grp,'partition',...
    holdoutCVP)/holdoutCVP.TestSize 

%%
% It is interesting to look at the plot of resubstitution MCE values on the
% training set (i.e., without performing cross-validation during the
% feature selection procedure) as a function of the number of features:
[fsResubfor100,historyResub] = sequentialfs(classf,dataTrain(:,fs1),...
     grpTrain,'cv','resubstitution','Nf',100);
plot(1:100, historyCV.Crit,'bo',1:100, historyResub.Crit,'r^');
xlabel('Number of Features');
ylabel('MCE');
legend({'10-fold CV MCE' 'Resubstitution MCE'},'location','NE');
%------------- END OF CODE --------------