mov=mmreader('MVI_1201.avi'); %读入 
vidFrames = read(mov);
numFrames = get(mov, 'numberOfFrames');
for i=1:numFrames 
strtemp=strcat('e:\',int2str(i),'.','jpg');%将每祯转成jpg的图片 
imwrite(vidFrames(:,:,:,i),strtemp); 
end
