function AppearanceData=AAM_MakeAppearanceModel(TrainingData,ShapeData,options)
% Make the gray-level Appearance Model

% Coordinates of mean contour
base_points = [ShapeData.x_mean(1:end/2) ShapeData.x_mean(end/2+1:end)];

% Normalize the base points to range 0..1
base_points = base_points - repmat(min(base_points),size(base_points,1),1);
base_points = base_points ./ repmat(max(base_points),size(base_points,1),1);

% Transform the mean contour points into the coordinates in the texture
% image.
base_points(:,1)=1+(options.texturesize(1)-1)*base_points(:,1);
base_points(:,2)=1+(options.texturesize(2)-1)*base_points(:,2);

% Draw the contour as one closed line white line and fill the resulting
% (hand) object
ObjectPixels= myDrawObject(base_points,options.texturesize);

% Number of datasets
s=length(TrainingData);


% Transform the hands images first into the mean texture image, and than
% transform the image into a vector using the pixellocations of the object
% found here above.

% Construct a matrix with all appearance data of the training data set
npixels=sum(ObjectPixels(:));
g=zeros(npixels*size(TrainingData(1).I,3),s);
for i=1:s
    g(:,i)=AAM_Appearance2Vector(TrainingData(i).I,TrainingData(i).x,TrainingData(i).y, base_points, ObjectPixels,options.texturesize);
end

% Normalize the greylevels, to compensate for illumination 
for i=1:s
    g(:,i)=AAM_NormalizeAppearance(g(:,i));
end
[Evalues, Evectors, g_mean]=PCA(g);

% Keep only 99% of all eigen vectors, (remove contour noise)
i=find(cumsum(Evalues)<sum(Evalues)*0.99,1,'last')+1;
Evectors=Evectors(:,1:i);
Evalues=Evalues(1:i);

% Store the Eigen Vectors and Eigen Values
AppearanceData.Evectors=Evectors;
AppearanceData.Evalues=Evalues;
AppearanceData.g_mean=g_mean;
AppearanceData.g = g;
AppearanceData.ObjectPixels=ObjectPixels;
AppearanceData.base_points=base_points;

