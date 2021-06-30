function pts = NormShape2TSize(bp, texturesize)

if 1
	base_points = [bp(1:end/2) bp(end/2+1:end)];
	
	% Normalize the base points to range 0..1
	base_points = base_points - repmat(min(base_points),size(base_points,1),1);
	base_points = base_points ./ repmat(max(base_points),size(base_points,1),1);
	
	% Transform the mean contour points into the coordinates in the texture
	% image.
	base_points(:,1)=1+(texturesize(1)-1)*base_points(:,1);
	base_points(:,2)=1+(texturesize(2)-1)*base_points(:,2);

	pts = base_points;
else
	% keep aspect ratio:
	base_points = bp;
	
	% Normalize the base points to range 0..1
	base_points = base_points - min(base_points);
	base_points = base_points ./ max(base_points);
	
    base_points = [base_points(1:end/2) base_points(end/2+1:end)];
	% Transform the mean contour points into the coordinates in the texture
	% image.
	base_points(:,1)=1+(texturesize(1)-1)*base_points(:,1);
	base_points(:,2)=1+(texturesize(2)-1)*base_points(:,2);

	pts = base_points;

end

