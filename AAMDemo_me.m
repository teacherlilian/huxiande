% This Script shows an example of a working basic Active Appearance Model (AAM),
% with a few hand pictures.
%
% Literature used:
% - T.F. Cootes, G.J Edwards, and C,J. Taylor "Active Appearance Models",
%   Proc. European Conference on Computer Vision 1998
% - T.F. Cootes, G.J Edwards, and C,J. Taylor "Active Appearance Models",
%   IEEE Transactions on Pattern Analysis and Machine Intelligence 2001
%
% Functions are written by D.Kroon University of Twente (March 2010)

%Add functions path to matlab search path
functionname='AAMDemo.m'; functiondir=which(functionname);
functiondir=functiondir(1:end-length(functionname));
addpath([functiondir '/AAM Functions'])
addpath([functiondir '/Functions'])
addpath([functiondir '/myFunctions'])

%% Set options
% Number of contour points interpolated between the major landmarks.
options.ni=50;
% Set normal appearance/contour, limit to +- m*sqrt( eigenvalue )
options.m=3;
% Size of texture appereance image
options.texturesize=[400 400];
% If verbose is true all debug images will be shown.
options.verbose=true;
% Number of image scales
options.nscales=1;
% Number of search itterations
options.nsearch=15;

numTrainSamples = 10;

dataDir = 'D:\Yale face points image';
%% Load training data
% First Load the Hand Training DataSets (Contour and Image)
% The LoadDataSetNiceContour, not only reads the contour points, but
% also resamples them to get a nice uniform spacing, between the important
% landmark contour points.
TrainingData=struct;
if(options.verbose), figure, end
for i=1:numTrainSamples
    filename = sprintf('%s\\points%d', dataDir, i);
    % Load the trianing data
    [TrainingData(i).x,TrainingData(i).y,TrainingData(i).I]=myLoadDataSetNiceContour_cp(filename,options.ni,options.verbose);
    % Replace the grey level photo by color photo
    TrainingData(i).I=im2double(imread([filename '.jpg']));
end

% The Active Appearance Model is constructed for multiple image scales.
% During search first the coarse scale is used to detect the object
% followed by the finer scales (larger images). This makes the model robust
% against initial location and local minima

% The structure which will contain the AAM model for 4 image scales
Data=cell(1,4);
for scale=1:options.nscales
    %% Shape Model %%
    % Make the Shape model, which finds the variations between contours
    % in the training data sets. And makes a PCA model describing normal
    % contours
    [ShapeData,TrainingData] = AAM_MakeShapeModel(TrainingData);
    
    % Show some eigenvector variations
    if(options.verbose)
        figure,
        for i=1:6
            xtest = ShapeData.x_mean + ShapeData.Evectors(:,i)*sqrt(ShapeData.Evalues(i))*3;
            subplot(3,3,i), hold on;
            DrawFaceShape(xtest(end/2+1:end),xtest(1:end/2),'r');
            DrawFaceShape(ShapeData.x_mean(end/2+1:end),ShapeData.x_mean(1:end/2),'b');
        end
    end
%     
%     %% Appearance model %%
%     % Piecewise linear image transformation is used to align all texture
%     % information inside the object (hand), to the mean handshape.
%     % After transformation of all trainingdata textures to the same shape
%     % PCA is used to describe the mean and variances of the object texture.
    AppearanceData=AAM_MakeAppearanceModel(TrainingData,ShapeData,options);
%     
    % Show some appearance mean and eigenvectors
    if(options.verbose)
        figure,
        I_texture=AAM_Vector2Appearance(AppearanceData.g_mean,AppearanceData.ObjectPixels,options.texturesize);
        
        ii = AdjustTexture(I_texture);
        
        subplot(2,2,1),imshow(ii,[]); title('mean grey');
        
        I_texture=AAM_Vector2Appearance(AppearanceData.Evectors(:,1),AppearanceData.ObjectPixels,options.texturesize);
        ii = AdjustTexture(I_texture);
        subplot(2,2,2),imshow(ii,[]); title('first eigenv');
        
        
        I_texture=AAM_Vector2Appearance(AppearanceData.Evectors(:,2),AppearanceData.ObjectPixels,options.texturesize);
        ii = AdjustTexture(I_texture);
        subplot(2,2,3),imshow(ii,[]); title('second eigenv');
        
        I_texture=AAM_Vector2Appearance(AppearanceData.Evectors(:,3),AppearanceData.ObjectPixels,options.texturesize);
        ii = AdjustTexture(I_texture);
        subplot(2,2,4),imshow(ii,[]); title('third eigenv');
    end
    
     
    cnt = 1;
    NumFaces = 50;
    
    avi_movie=dir('D:\AAM\*.avi');
    j=length(avi_movie);
    movie_name=[num2str(j),'.avi'];
     aviobj= avifile(char(movie_name));
     aviobj.fps=25.0000;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Now let's have fun with eigen face shapes and textures...
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Is = DoCrossFace2(AppearanceData, ShapeData, 1, 2, NumFaces, options.texturesize);
    figure(11);
    for i=1:NumFaces+1
        %subplot(8, NumFaces+1, cnt);
        cnt = cnt + 1;
         imshow(Is(:, :, :, i))
     aviobj=addframe(aviobj,Is(:,:,:,i));
    end
   
    
    Is = DoCrossFace2(AppearanceData, ShapeData, 2, 3, NumFaces, options.texturesize);
    figure(11);
    for i=1:NumFaces+1
        %subplot(8, NumFaces+1, cnt);
        cnt = cnt + 1;
        imshow(Is(:, :, :, i));
         aviobj=addframe(aviobj,Is(:,:,:,i));
    end
    
    Is = DoCrossFace2(AppearanceData, ShapeData, 3, 4, NumFaces, options.texturesize);
    figure(11);
    for i=1:NumFaces+1
        %subplot(8, NumFaces+1, cnt);
        cnt = cnt + 1;
        imshow(Is(:, :, :, i));
        aviobj=addframe(aviobj,Is(:,:,:,i));
    end

    Is = DoCrossFace2(AppearanceData, ShapeData, 4, 5, NumFaces, options.texturesize);
    figure(11);
    for i=1:NumFaces+1
        %subplot(8, NumFaces+1, cnt);
        cnt = cnt + 1;
        imshow(Is(:, :, :, i));
        aviobj=addframe(aviobj,Is(:,:,:,i));
    end
    
    Is = DoCrossFace2(AppearanceData, ShapeData, 5, 6, NumFaces, options.texturesize);
    figure(11);
    for i=1:NumFaces+1
        %subplot(8, NumFaces+1, cnt);
        cnt = cnt + 1;
        imshow(Is(:, :, :, i));
        aviobj=addframe(aviobj,Is(:,:,:,i));
    end
    
    Is = DoCrossFace2(AppearanceData, ShapeData, 6, 7, NumFaces, options.texturesize);
    figure(11);
    for i=1:NumFaces+1
        %subplot(8, NumFaces+1, cnt);
        cnt = cnt + 1;
        imshow(Is(:, :, :, i));
        aviobj=addframe(aviobj,Is(:,:,:,i));
    end
    
      Is = DoCrossFace2(AppearanceData, ShapeData, 7, 8, NumFaces, options.texturesize);
    figure(11);
    for i=1:NumFaces+1
        %subplot(8, NumFaces+1, cnt);
        cnt = cnt + 1;
        imshow(Is(:, :, :, i));
        aviobj=addframe(aviobj,Is(:,:,:,i));
    end
    
    Is = DoCrossFace2(AppearanceData, ShapeData, 8, 9, NumFaces, options.texturesize);
    figure(11);
    for i=1:NumFaces+1
        %subplot(8, NumFaces+1, cnt);
        cnt = cnt + 1;
        imshow(Is(:, :, :, i));
        aviobj=addframe(aviobj,Is(:,:,:,i));
    end
    
      
    Is = DoCrossFace2(AppearanceData, ShapeData, 9, 10, NumFaces, options.texturesize);
    figure(11);
    for i=1:NumFaces+1
        %subplot(8, NumFaces+1, cnt);
        cnt = cnt + 1;
        imshow(Is(:, :, :, i));
        aviobj=addframe(aviobj,Is(:,:,:,i));
    end
    
      
    Is = DoCrossFace2(AppearanceData, ShapeData, 10, 1, NumFaces, options.texturesize);
    figure(11);
    for i=1:NumFaces+1
        %subplot(8, NumFaces+1, cnt);
        cnt = cnt + 1;
        imshow(Is(:, :, :, i));
        aviobj=addframe(aviobj,Is(:,:,:,i));
    end
    
  
    aviobj=close(aviobj);
    %% Skip the following for now.
    if 0
        
        %%% Combined model %%
        % Often Shape and Texture are correlated in some way. Thus we can use
        % PCA to get a combined Shape-Appearance model.
        ShapeAppearanceData=AAM_CombineShapeAppearance(TrainingData,ShapeData,AppearanceData,options);
        
        if (options.verbose);
            % Show diffference between an original texture, and the original
            % texture described by the combined model. (Are exactly the same
            % if no eigenvectors variations are removed after PCA)
            for i=1:2
                % Orignal texture
                I_texture=AAM_Vector2Appearance(AppearanceData.g(:,i),AppearanceData.ObjectPixels,options.texturesize);
                
                % Appearance parameters to shape-appearance parameters
                c = ShapeAppearanceData.Evectors'*(ShapeAppearanceData.b(:,i) -ShapeAppearanceData.b_mean) ;
                % Back from Shape-appearance parameters to appearance
                % parameters
                b = ShapeAppearanceData.b_mean + ShapeAppearanceData.Evectors*c;
                b2 = b((length(ShapeAppearanceData.Ws)+1):end);
                g = AppearanceData.g_mean + AppearanceData.Evectors*b2;
                I_texture2=AAM_Vector2Appearance(g,AppearanceData.ObjectPixels,options.texturesize);
                
                figure,
                subplot(1,3,1),imshow(I_texture,[]); title('original texture');
                subplot(1,3,2),imshow(I_texture2,[]); title('Texture made by the combined model');
                subplot(1,3,3),imshow((I_texture2-I_texture).^2,[]);
                title('Difference between original texture and texture described by the model');
            end
        end
        
        %%% Search Model %%
        % The Search Model is used to find the object location and
        % shape-appearance parameters, in a test set.
        % Training is done by displacing the Model and translation parameters
        % with a known amount, and measuring the error, between the intensities
        % form the real image, and those intensities described by the model.
        % The found error correlations are used to make the inverse model which
        % gives the optimial parameter update and new location when you input
        % the error vector with difference between model and real intensities.
        R=AAM_MakeSearchModel(ShapeAppearanceData,ShapeData,AppearanceData,TrainingData,options);
        
        % The PCA model is finished, and we store the resulting variables
        % in the data structure, which will contain the Model for 4 different
        % image scales
        Data{scale}.R=R;
        Data{scale}.ShapeAppearanceData=ShapeAppearanceData;
        Data{scale}.ShapeData=ShapeData;
        Data{scale}.AppearanceData=AppearanceData;
        Data{scale}.TrainingData=TrainingData;
        
    end
    
    % Transform the image to a coarser scale, and update the
    % contour positions.
    for i=1:length(TrainingData)
        TrainingData(i).x=TrainingData(i).x/2;
        TrainingData(i).y=TrainingData(i).y/2;
        TrainingData(i).I=imresize(TrainingData(i).I,1/2);
    end
end

return;

%% Applying the model %%%
% Finding and describing the object (hand) in a test image, using
% the multiscale model. We start with the mean shape on the location
% specified below, and use the searchmodel to find the hand location,
% shape and appearance.
Itest=(im2double(imread('Fotos/test001.jpg')));

% Initial position offset and rotation, of the initial/mean contour
tform.offsetx=0; tform.offsety=0; tform.offsetr=0;
posx=Data{1}.ShapeData.x_mean(1:end/2)';
posy=Data{1}.ShapeData.x_mean(end/2+1:end)';
% Parameters describing, scale and rotation in comparison with the mean
% hand shape, sx = size*cos(angle), sy=size*sin(angle)
tform.offsetsx= 1; tform.offsetsy= 0;

[posx,posy]=ASM_align_data_inverse(posx,posy,tform);

% Select the best starting position with the mouse
[x,y]=SelectPosition(Itest,posx,posy);
tform.offsetx=-x; tform.offsety=-y;


AAM_ApplyModel(Itest,tform,Data,options);
