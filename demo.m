%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FaceDB data demo
% Written by:
%       Yan Xiaoguang
% Date:
%       2010-10-02
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numImgs = 8;
dataDir = 'point-images';

orFace = [1 2 4 6 8 10 12 14 15 13 11 9 7 5 3 1];
orEbrowL = [20 18 16 22 20];
orEbrowR = [17 19 21 23 17];
orEyeL = [26 28 24 30 26];
orEyeR = [25 29 27 31 25];
orNose = [32 34 36 39 37 38 35 33 32];
orMouth = [40 42 44 43 41 45 40 46 47];

capX = [];

for i=1:numImgs
    dataFile = sprintf('%s\\no.%d', dataDir, i);
    
    [x y]= LoadDataFile(dataFile);
    
    % inverse y for better visual
    y = -y;

    % do visual
    if 1
        figure(i);
        hold on;
        plot(x(orFace), y(orFace));
        plot(x(orEbrowL), y(orEbrowL));
        plot(x(orEbrowR), y(orEbrowR));
        line(x(orEyeL), y(orEyeL));
        line(x(orEyeR), y(orEyeR));
        line(x(orNose), y(orNose));
        line(x(orMouth), y(orMouth));
        hold off;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(i==1)
        centerxy = [x' y'];
        continue;
    end
    
    % Align data using procrustes analysis
    tempxy = [x' y'];
    [d z] = procrustes(centerxy, tempxy);
    
    x = z(:, 1)';
    y = z(:, 2)';
    
    % Add to data matrix
    capX = [capX; x y];
    

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do PCA
%meanX = mean(capX');
[coeff, vec, mean] = PCA(capX');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do appearance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


