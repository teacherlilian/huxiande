function Faces = DoCrossFace2(AppearanceData, ShapeData, Idx0, Idx1, NumFaces, texturesize)
% create a face cross between idx0 and idx1


Faces = uint8(zeros(texturesize(1), texturesize(2), 3, NumFaces+1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% First: textures only.
%%% Let's see how much each face projects to eigen face.
gs = AppearanceData.g;
g0 = gs(:, Idx0);
w0 = g0'*AppearanceData.Evectors;

g1 = gs(:, Idx1);
w1 = g1'*AppearanceData.Evectors;

dw = (w1-w0)/NumFaces;



gmean = AppearanceData.g_mean;
ev = AppearanceData.Evectors;

i_s = zeros(texturesize(1), texturesize(2), 3, NumFaces+1);

for loop = 1:NumFaces+1
    % i0 as I0 (texture only)
    w = w0+(loop-1)*dw;
    face = gmean;
    for i=1:size(w, 2)
        face = face + 1*w(1, i)*ev(:, i);
    end
    
    img=AAM_Vector2Appearance(face,AppearanceData.ObjectPixels,texturesize);
    if(size(img, 3)==3)
        i_s(:, :, :, loop) = img;
    else
        i_s(:, :, 1, loop) = img;
        i_s(:, :, 2, loop) = img;
        i_s(:, :, 3, loop) = img;
    end
    
    %ii = AdjustTexture(i_s(:, :, :, loop));
    %imshow(ii);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Now add shape factor.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s_mean = NormShape2TSize(ShapeData.x_mean, texturesize);


base_points = ShapeData.x_mean;

s0 = ShapeData.x(:, Idx0) - base_points;
w0 = s0'*ShapeData.Evectors;


s1 = ShapeData.x(:, Idx1) - base_points;
w1 = s1'*ShapeData.Evectors;

dw = (w1-w0)/NumFaces;


for loop = 1:NumFaces+1
    w = w0+dw*(loop-1);
    
    target_points = ShapeData.x_mean;
    for i=1:size(w, 2)
        target_points = target_points + w(1, i)*ShapeData.Evectors(:, i);
    end
    
    ww = NormShape2TSize(target_points, texturesize);
    
    if 0
        figure(1);
        DrawFaceShape(s_mean(:, 2),s_mean(:, 1),'r');
        hold on;
        DrawFaceShape(ww(:, 2),ww(:, 1),'g');
    end
    
    basex = s_mean(:, 1);
    basey = s_mean(:, 2);
    targetx = ww(:, 1);
    targety = ww(:, 2);
    newImg = ReshapeImage(i_s(:, :, :, loop), [basex basey], [targetx targety], texturesize);
    ww = AdjustTexture(newImg);
    Faces(:, :, :, loop) = ww;
%    imshow(Faces(:, :, :, loop));
    
end
