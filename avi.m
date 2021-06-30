face=dir('D:\PCA\point-images\*.jpg'); 
face_size=size(face);
num=face_size(1); 
for i=1:num 
im(:,:,:,i)=imread(['no.',num2str(i),'.jpg']); 
imshow(Is);
movieframe(i) = getframe; 
end
avi_movie=dir('*.avi');
j=length(avi_movie);
movie_name=[num2str(j),'.avi'];
movie2avi(movieframe,char(movie_name),'FPS',1);