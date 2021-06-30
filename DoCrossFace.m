function [I0 I1 I2 I3] = DoCrossFace(AppearanceData, ShapeData, Idx0, Idx1, texturesize)
% create a face cross between idx0 and idx1


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% First: textures only.
%%% Let's see how much each face projects to eigen face.
gs = AppearanceData.g;
g0 = gs(:, Idx0);
w0 = g0'*AppearanceData.Evectors;

g1 = gs(:, Idx1);
w1 = g1'*AppearanceData.Evectors;

dw = (w1-w0)/3;



gmean = AppearanceData.g_mean;
ev = AppearanceData.Evectors;

% i0 as I0 (texture only)
w = w0;
face = gmean;
for i=1:size(w, 2)
    face = face + 1*w(1, i)*ev(:, i);
end

i0=AAM_Vector2Appearance(face,AppearanceData.ObjectPixels,texturesize);
%i0 = AdjustTexture(i0);
%imshow(ii);

% i1 as I1 (texture only)
w = w0 + dw;
face = gmean;
for i=1:size(w, 2)
    face = face + 1*w(1, i)*ev(:, i);
end

i1=AAM_Vector2Appearance(face,AppearanceData.ObjectPixels,texturesize);
%i1 = AdjustTexture(i1);

% i2 as I2 (texture only)
w = w0 + 2*dw;
face = gmean;
for i=1:size(w, 2)
    face = face + 1*w(1, i)*ev(:, i);
end

i2=AAM_Vector2Appearance(face,AppearanceData.ObjectPixels,texturesize);
%i2 = AdjustTexture(i2);

% i0 as I0 (texture only)
w = w0 + 3*dw;
face = gmean;
for i=1:size(w, 2)
    face = face + 1*w(1, i)*ev(:, i);
end

i3=AAM_Vector2Appearance(face,AppearanceData.ObjectPixels,texturesize);
%i3 = AdjustTexture(i3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Now add shape factor.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s_mean = NormShape2TSize(ShapeData.x_mean, texturesize);


base_points = ShapeData.x_mean;

s0 = ShapeData.x(:, Idx0) - base_points;
w0 = s0'*ShapeData.Evectors;


s1 = ShapeData.x(:, Idx1) - base_points;
w1 = s1'*ShapeData.Evectors;

dw = (w1-w0)/3;

% si0 as the shape for I0 (shape only)
w = w0;
target_points = ShapeData.x_mean;    
for i=1:size(w, 2)
    target_points = target_points + w(1, i)*ShapeData.Evectors(:, i);
end

si0 = NormShape2TSize(target_points, texturesize);

if 0
    figure(1);
    DrawFaceShape(s_mean(:, 2),s_mean(:, 1),'r');
    hold on;
    DrawFaceShape(si0(:, 2),si0(:, 1),'g');
end 

basex = s_mean(:, 1);
basey = s_mean(:, 2);
targetx = si0(:, 1);
targety = si0(:, 2);
newImg = ReshapeImage(i0, [basex basey], [targetx targety], texturesize);
I0 = AdjustTexture(newImg);

% si1 as the shape for I1 (shape only)
w = w0 + dw;
target_points = ShapeData.x_mean;    
for i=1:size(w, 2)
    target_points = target_points + w(1, i)*ShapeData.Evectors(:, i);
end

si1 = NormShape2TSize(target_points, texturesize);

basex = s_mean(:, 1);
basey = s_mean(:, 2);
targetx = si1(:, 1);
targety = si1(:, 2);
newImg = ReshapeImage(i1, [basex basey], [targetx targety], texturesize);
I1 = AdjustTexture(newImg);

% si2 as the shape for I2 (shape only)
w = w0 + 2*dw;
target_points = ShapeData.x_mean;    
for i=1:size(w, 2)
    target_points = target_points + w(1, i)*ShapeData.Evectors(:, i);
end

si2 = NormShape2TSize(target_points, texturesize);

basex = s_mean(:, 1);
basey = s_mean(:, 2);
targetx = si2(:, 1);
targety = si2(:, 2);
newImg = ReshapeImage(i2, [basex basey], [targetx targety], texturesize);
I2 = AdjustTexture(newImg);


% si3 as the shape for I2 (shape only)
w = w0 + 3*dw;
target_points = ShapeData.x_mean;    
for i=1:size(w, 2)
    target_points = target_points + w(1, i)*ShapeData.Evectors(:, i);
end

si3 = NormShape2TSize(target_points, texturesize);

basex = s_mean(:, 1);
basey = s_mean(:, 2);
targetx = si3(:, 1);
targety = si3(:, 2);
newImg = ReshapeImage(i3, [basex basey], [targetx targety], texturesize);
I3 = AdjustTexture(newImg);