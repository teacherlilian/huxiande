mov=mmreader('MVI_1201.avi'); %���� 
vidFrames = read(mov);
numFrames = get(mov, 'numberOfFrames');
for i=1:numFrames 
strtemp=strcat('e:\',int2str(i),'.','jpg');%��ÿ��ת��jpg��ͼƬ 
imwrite(vidFrames(:,:,:,i),strtemp); 
end
