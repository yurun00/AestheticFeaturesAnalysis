addr = '..\..\..\test\data\saliency\';
imgs = {[addr,'courtyard-of-a-farm-at-saint-mammes-1884.jpg']};
[salMaps,fixations,shapes] = aayrrunSaliency([addr,'courtyard-of-a-farm-at-saint-mammes-1884.jpg'],5);