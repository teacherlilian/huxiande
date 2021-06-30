function DrawFaceShape(x, y, color)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw face given x, y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

orFace = [1 2 4 6 8 10 12 14 16 18 20 22 24 26 27 25 23 21 19 17 15 13 11 9 7 5 3 1];
%orEbrowL = [28 30 32 34 36 38 28];
%orEbrowR = [29 31 33 35 37 39 29];
orEyeL = [28 30 32 34 36 38 28];
orEyeR = [29 31 33 35 37 39 29];
orNose = [47 43 41 40 42 44 48 45 47 46 48 45 47];
orMouth = [54 52 50 49 51 53 55 58 56 57 54 60 59 61 55 66 64 62 63 65 54];

% inverse y for better visual
y = -y;
 
% do visual
if 1
    hold on;
    plot(x(orFace), y(orFace), color);
    %plot(x(orEbrowL), y(orEbrowL), color);
    %plot(x(orEbrowR), y(orEbrowR), color);
    plot(x(orEyeL), y(orEyeL), color);
    plot(x(orEyeR), y(orEyeR), color);
    plot(x(orNose), y(orNose), color);
    plot(x(orMouth), y(orMouth), color);
    hold off;
end

