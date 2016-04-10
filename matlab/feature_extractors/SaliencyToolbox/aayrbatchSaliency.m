% batchSaliency - batch processing of lists of images.
%
% salMaps = batchSaliency(images)
%    Computes the saliency maps for a number of images.
%    images can be one of the following:
%       - a vector of Image structures as obtained from initializeImage
%       - a cell array of file names of image files
%       - the name of a directory - using all image files 
%         in that directory
%
% [salMaps,fixations] = batchSaliency(images,numFixations)
%    Computes the saliency maps and the coordinates of the first
%    numFixations fixations. fixations is a cell array with one cell
%    for each image. Each cell is of size numFixations x 2.
%
% [salMaps,fixations] = batchSaliency(images,numFixations,params)
%    Uses params as the saliency parameters. By default, the parameters
%    from defaultSaliencyParams are used.
%
% See also initializeImage, makeSaliencyMap, defaultSaliencyParams,
%          runSaliency, dataStructures.

% This file is part of the SaliencyToolbox - Copyright (C) 2006-2013
% by Dirk B. Walther and the California Institute of Technology.
% See the enclosed LICENSE.TXT document for the license agreement. 
% More information about this project is available at: 
% http://www.saliencytoolbox.net

function [salMaps,fixations] = aayrbatchSaliency(images,numFixations,params)

if (nargin < 2)
  numFixations = 0;
end

if (nargin < 3)
  params = defaultSaliencyParams;
end

% convert images input argument into Image structures
switch class(images)
  case 'cell'
    imgList = [];
    for f = 1:length(images)
      [imgStruct,err] = initializeImage(images{f});
      if isempty(err)
        imgList = [imgList imgStruct];
      else
        fprintf(['Error reading image file ' images{f} ': ' err.message ' = skipping\n']);
      end
    end
    fprintf('Found %d images.\n',length(imgList));    
  case 'struct'
    imgList = images;
  case 'char'
    d = dir(images);
    imgFiles = {d(~[d.isdir]).name};
    if isempty(imgFiles)
      fprintf(['No image files found in ' images '\n']);
      salMaps = []; fixations = {};
      return;
    end
    imgList = [];
    for f = 1:length(imgFiles)
      [imgStruct,err] = initializeImage(fullfile(images,imgFiles{f}));
      if isempty(err)
        imgList = [imgList imgStruct];
      end
    end
    fprintf('Found %d images.\n',length(imgList));
  otherwise
    error(['Type ' class(images) 'not valid for images input argument.']);
end

% loop over all images
numImg = length(imgList);
fixations = {};
for f = 1:numImg
  fprintf('Processing image %d of %d: computing saliency map ...',f,numImg);

  % make sure that we don't use color features if we don't have a color image
  myParams = params;
  if (imgList(f).dims == 2)
    myParams = removeColorFeatures(myParams);
  end
  
  % compute the saliency map
  [salMaps(f),salData] = makeSaliencyMap(imgList(f),myParams);
  
%   % display the saliency maps
%   salFig = figure('Name','saliency maps','NumberTitle','off'); 
%   displayMaps({salMaps(f)},2);
  
  % need to compute fixations?
  if (numFixations > 0)
    fprintf(' computing %d fixations ',numFixations);
    wta = initializeWTA(salMaps(f),myParams);
    
    imgFig = showImage(imgList(f));
    lastWinner = [-1,-1];
    shapeFig = -1;
    
    % loop over the fixations
    for fix = 1:numFixations
      
      % evolve WTA until we have the next winner
      winner = [-1,-1];
      while(winner(1) == -1)
        [wta,winner] = evolveWTA(wta);
      end
      fprintf('.');
      
      % get shape data and apply inhibition of return
      shapeData = estimateShape(salMaps(f),salData,winner,myParams);
      wta = applyIOR(wta,winner,myParams,shapeData);
      
      % convert the winner's location to image coordinates
      win2 = winnerToImgCoords(winner,myParams);
      
      % plot the currently attended region into the image figure
      figure(imgFig);
      plotSalientLocation(win2,lastWinner,imgList(f),myParams,shapeData);
      lastWinner = win2;
      
      % convert the winner to image coordinates
      fixations{f}(fix,:) = winnerToImgCoords(winner,myParams);
      
%       % in case we have shape data, create a plot 
%       % to display various processing steps
%       if ~isempty(shapeData)
% 
%         % need to open a new figure or use the previous one?
%         if (shapeFig == -1) 
%           shapeFig = figure('Name','STB: shape maps ','NumberTitle','off'); 
%         else
%           figure(shapeFig);
%         end
% 
%         % draw the various maps
%         displayMaps({shapeData.winningMap,shapeData.segmentedMap,...
%                      shapeData.binaryMap,shapeData.shapeMap});
% 
%         % find the right label for the figure window
%         winLabel = [' - ' shapeData.winningMap.label];
%         if any(isnan(imgList(f).filename))
%           lab = winLabel;
%         else
%           lab = [imgList(f).filename winLabel];
%         end
%         set(imgFig,'Name',lab);
%       else
%         winLabel = '';
%       end
% 
      % make sure everything gets drawn
%       drawnow;
% 
%       % write out the details for our winner
%       txt = sprintf('winner: %i,%i; t = %4.1f ms%s',...
%                     win2(2),win2(1),wta.exc.time*1000,winLabel);
    end
  end
  fprintf(' done.\n');
end

