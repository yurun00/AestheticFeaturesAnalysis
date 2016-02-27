function features = rgbhist_select (g1,g2)
% RGBHIST_SELECT - This program selects features from RGB histogram. It is 
% related to the topic on how to select features for classifying 
% high-dimensional data. It performs sequential feature selection(SFS) on 
% the preprocessed dataset and uses holdout and cross-validation to 
% evaluate the performance of the selected features.
%
% Syntax: FEATURES = RGBHIST_SELECT (G1, G2);
%
% Inputs:
%   g1, g2 - String variables represent genres.
%
% Outputs:
%   features - The selected important features.
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
% Created: 02/17/2016; Last revision: 02/27/2016

%------------- BEGIN CODE --------------

% ----- Load the data -----
addr = '..\..\..\data\features\rgb_hist\genre\';
addr_g1_ftr = strcat(addr,g1,'\');
addr_g2_ftr = strcat(addr,g2,'\');
rgbhist_mat_g1 = dir(fullfile(addr_g1_ftr,'*.mat'));
rgbhist_mat_g2 = dir(fullfile(addr_g2_ftr,'*.mat'));

% Store the category of corresponding painting's histogram
grp = cell(length(rgbhist_mat_g1) + length(rgbhist_mat_g2), 1);
addi = 0;

% RGB histogram matrix of landscape images
rgbhist_g1 = zeros(length(rgbhist_mat_g1), 512);
for i=1:length(rgbhist_mat_g1) 
        %Load rgbhist
        rgbhist_in = load([addr_g1_ftr,rgbhist_mat_g1(i).name]);
        rgbhist_in = rgbhist_in.rgbhist;
        
        %Concatenate the rgbhist
        rgbhist_g1(i,:) = rgbhist_in';
        
        grp{i+addi} = g1;
end
addi = addi + length(rgbhist_mat_g1);

%RGB histogram matrix of portrait images
rgbhist_g2 = zeros(length(rgbhist_mat_g2), 512);
for i=1:length(rgbhist_mat_g2)
        %Load rgbhist
        rgbhist_in = load([addr_g2_ftr,rgbhist_mat_g2(i).name]);
        rgbhist_in = rgbhist_in.rgbhist;
        
        %Concatenate the rgbhist
        rgbhist_g2(i,:) = rgbhist_in';
        
        grp{i+addi} = g2;
end

obs = [rgbhist_g1;rgbhist_g2];

% ----- Dividing Data Into a Training Set and a Test Set -----
holdoutCVP = cvpartition(grp,'holdout',0.2);
dataTrain = obs(holdoutCVP.training,:);
grpTrain = grp(holdoutCVP.training);

% ----- The Problem of Classifying Data Using All the Features -----
% If one uses Quadratic Discriminant Analysis (QDA) as the classification
% algorithm and applies QDA on the data using all the features, an error 
% may occur here because there are not enough samples in each group to 
% estimate a covariance matrix. 
try
   yhat = classify(obs(test(holdoutCVP),:), dataTrain, grpTrain,'quadratic');
catch ME
   display(ME.message);
end

% ----- Selecting Features Using a Simple Filter Approach -----
% Fileter methods are applied as pre-processing step first and wrapper 
% methods are applied later to search for features better fit for the 
% chosen learning algorithm considering the efficiency.
%
% The _t_-test is applied on each feature and the _p_-value (or the 
% absolute values of _t_-statistics) is compared for each feature as a 
% measure of how effective it is at separating groups.
dataTrainG1 = dataTrain(grp2idx(grpTrain)==1,:);
dataTrainG2 = dataTrain(grp2idx(grpTrain)==2,:);
[h,p,ci,stat] = ttest2(dataTrainG1,dataTrainG2,'Vartype','unequal');

%Plot the empirical cumulative distribution function(CDF) of the _p_-values
ecdf(p);
xlabel('P value'); 
ylabel('CDF value');

% The_p_-values of features close to zero means that the feature have
% strong discrimination power.One can sort these features according to 
% their _p_-values (or the absolute values of the _t_-statistic) and select
% some features from the sorted list.
%
% Plot the MCE (misclassification error) on the test set as a function of 
% the number of features to decide the number of needed features.
%
% Use the 80% training samples to fit the QDA model and compute the MCE on 
% the 20% test observations (blue circular marks in the following plot). 
% Also show the resubstitution MCE using red triangular marks.
mxfn = sum(p < 0.05);
mxfn = ceil(mxfn/5);
[~,featureIdxSortbyP] = sort(p,2);
% testMCE = zeros(1,51);
% resubMCE = zeros(1,51);
testMCE = zeros(1,mxfn);
resubMCE = zeros(1,mxfn);
% nfs = 10:10:510;
nfs = 5:5:mxfn*5;
% |classf| fits QDA on the given training set and returns the number of 
% misclassified samples for the given test set. 

%  function err = classf(xtrain,ytrain,xtest,ytest)
%       yfit = classify(xtest,xtrain,ytrain,'quadratic');
%       err = sum(~strcmp(ytest,yfit));
classf = @(xtrain,ytrain,xtest,ytest) ...
             sum(~strcmp(ytest,classify(xtest,xtrain,ytrain,'quadratic')));
resubCVP = cvpartition(length(grp),'resubstitution');
% With more features,the Quadratic Discriminant Analysis (QDA) will get an 
% error because there are not enough samples in each group to estimate a 
% covariance matrix. 
% for i = 1:51
for i = 1:mxfn
   fs = featureIdxSortbyP(1:nfs(i));
   testMCE(i) = crossval(classf,obs(:,fs),grp,'partition',holdoutCVP)...
       /holdoutCVP.TestSize;
   resubMCE(i) = crossval(classf,obs(:,fs),grp,'partition',resubCVP)/...
       resubCVP.TestSize;
end
save(strcat(addr,'_f_sel_mce\',g1,'_',g2,'_filter_testMCE.mat'),'testMCE');
save(strcat(addr,'_f_sel_mce\',g1,'_',g2,'_filter_resubMCE.mat'),'resubMCE');
plot(nfs, testMCE,'o',nfs,resubMCE,'r^');
xlabel('Number of Features');
ylabel('MCE');
legend({'MCE on the test set' 'Resubstitution MCE'},'location','NW');
title('Simple Filter Feature Selection Method');
[~, mxfn] = min(testMCE);
mxfn = mxfn*5;
features = featureIdxSortbyP(1:mxfn);
% ----- Applying Sequential Feature Selection -----
% The feature selection procedure performs a sequential search with the MCE
% of the learning algorithm QDA on each candidate feature subset as the 
% performance indicator for the subset.

% Apply stratified 10-fold cross-validation to the training set.
tenfoldCVP = cvpartition(grpTrain,'kfold',10);

% Use the filter results from the previous section as a pre-processing step
% to select features.
fs1 = features;

% Aapply forward sequential feature selection on the features.
% The function |sequentialfs| stops when the first local minimum of the 
% cross-validation MCE is found.
fsLocal = sequentialfs(classf,dataTrain(:,fs1),grpTrain,'cv',tenfoldCVP);

% Compute the MCE of selected features on the test samples.
testMCELocal = crossval(classf,obs(:,fs1(fsLocal)),grp,'partition',...
    holdoutCVP)/holdoutCVP.TestSize;

% The algorithm may have stopped prematurely. Sometimes a smaller MCE is
% achievable by looking for the minimum of the cross-validation MCE over a
% reasonable range of number of features. 
[fsCVforMX,historyCV] = sequentialfs(classf,dataTrain(:,fs1),grpTrain,...
    'cv',tenfoldCVP,'Nf',mxfn);
sfsMCE = historyCV.Crit;

% Select featuers when the cross-validation MCE reaches the minimum .
[~, mnfn] = min(sfsMCE);
features = fs1(historyCV.In(mnfn,:));

save(strcat(addr,'_f_sel_mce\',g1,'_',g2,'_sfs_mce_fs.mat'),'sfsMCE',features);
% Draw the plot of the cross-validation MCE as a function of the number of 
% features.
plot(sfsMCE,'o');
xlabel('Number of Features');
ylabel('CV MCE');
title('Forward Sequential Feature Selection with cross-validation');

% Compute the MCE for QDA on the test set.
testMCECV = crossval(classf,obs(:,features),grp,'partition',...
    holdoutCVP)/holdoutCVP.TestSize;
end
%------------- END OF CODE --------------