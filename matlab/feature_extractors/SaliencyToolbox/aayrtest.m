addr = '..\..\..\test\data\saliency\';
imgs = {[addr,'courtyard-of-a-farm-at-saint-mammes-1884.jpg']};
[salMaps,fixations,shapes] = aayrrunSaliency([addr,'portrait-of-jacqueline-roque-with-her-hands-crossed-1954.jpg'],5);