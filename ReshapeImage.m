function newImg = ReshapeImage(in, input, base, texturesize)

uv=[input(:,2) input(:,1)];
xy=[base(:,2) base(:,1)];



if 0
figure;
hold on;
DrawFaceShape(input(:, 2), input(:, 1), 'r');
DrawFaceShape(base(:, 2), base(:, 1), 'g');
hold off;
axis([0 100 -100 0]);
end

% Remove control points which give folded over triangles with cp2tform
[uv xy]=PreProcessCp2tform(uv,xy);
trans_prj = cp2tform(uv,xy,'piecewise linear');

% Transform the image into the default texture image
newImg = imtransform(in,trans_prj,'Xdata',[1 texturesize(1)],'YData',[1 texturesize(2)],'XYscale',1);
