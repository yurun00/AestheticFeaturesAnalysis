% runSaliency - compute and display saliency map and fixations.
%
% runSaliency(inputImage,saliencyParams)
%    Runs a demonstration of the entire process of computing
%    the saliency map, winner-take-all evolution with 
%    inhibition of return, shape estimation, and fixation
%    to the attended region.
%       inputImage: the file name of the image,
%                   or the image data themselves,
%                   or an initialized Image structure (see initializeImage);
%       saliencyParams: the saliency parameter set for the operations.
%
% runSaliency(inputImage)
%    Uses defaultSaliencyParams as parameters.
%
% See also guiSaliency, batchSaliency, initializeGlobal, initializeImage, 
%          makeSaliencyMap, initializeWTA, evolveWTA, applyIOR, estimateShape, 
%          dataStructures, defaultSaliencyParams. 

% This file is part of the SaliencyToolbox - Copyright (C) 2006-2013
% by Dirk B. Walther and the California Institute of Technology.
% See the enclosed LICENSE.TXT document for the license agreement. 
% More information about this project is available at: 
% http://www.saliencytoolbox.net

function [salmap,fixations,shapes] = aayrrunSaliency(inputImage,numFixations,varargin)

declareGlobal;

% initialize the Image structure if necessary
if (isa(inputImage,'struct'))
  img = inputImage;
else
  img = initializeImage(inputImage);
end

% % check that image isn't too huge
% img = checkImageSize(img,'Prompt');

% use the default saliency parameters if the user didn't specify any
if isempty(varargin)
  params = defaultSaliencyParams(img.size,'dyadic');
else
  params = varargin{1};
end

% make sure that we don't use color features if we don't have a color image
if (img.dims == 2)
  params = removeColorFeatures(params);
end

% create the saliency map
[salmap,salData] = makeSaliencyMap(img,params);

% need to compute fixations?
if (numFixations > 0)
    
  % initialize the winner-take-all network
  wta = initializeWTA(salmap,params);
  
  % display the input image
  imgFig = showImage(img);
  shapeFig = -1;
  lastWinner = [-1,-1];

  
  % loop over the fixations
  for fix = 1:numFixations
      
    % evolve WTA until we have the next winner
    winner = [-1,-1];
    
    % evolve WTA until we have a winner
    while (winner(1) == -1)
      [wta,winner] = evolveWTA(wta);
    end
    
    % run the shape estimator to get proro-objects
    shapeData = estimateShape(salmap,salData,winner,params);
    shapes(fix,:,:) = im2bw(shapeData.shapeMap.data,0);
    
    % trigger inhibition of return
    wta = applyIOR(wta,winner,params,shapeData);
      
    % convert the winner's location to image coordinates
    win2 = winnerToImgCoords(winner,params);
      
    % plot the currently attended region into the image figure
    figure(imgFig);
    plotSalientLocation(win2,lastWinner,img,params,shapeData);
    
    lastWinner = win2;
      
    % convert the winner to image coordinates
    fixations(fix,:) = winnerToImgCoords(winner,params);
      
%     % in case we have shape data, create a plot 
%     % to display various processing steps
%     if ~isempty(shapeData)
%     
%       % need to open a new figure or use the previous one?
%       if (shapeFig == -1) 
%         shapeFig = figure('Name','STB: shape maps','NumberTitle','off'); 
%       else
%         figure(shapeFig);
%       end
%     
%       % draw the various maps
%       displayMaps({shapeData.winningMap,shapeData.segmentedMap,...
%                    shapeData.binaryMap,shapeData.shapeMap});
%     end
%     
%     % make sure everything gets drawn
%     drawnow;
  end
  
end
  
end
