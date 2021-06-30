function CreatAviFromPic(picfrom,picend,picformat,aviname)
%把图片集合成一段avi视频
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 施云涛 2009年01月08日
% 使用avifile、addframe、getframe等函数实现
% 输入: 
%      picfrom起始位置
%      picend终止位置
%      picformat图片格式,以字符输入
%      aviname生成avi的名字,必须带后缀名,以字符输入
%输出:当前目录下,名字为aviname的视频文件
%备注:所有图片的大小必须与第一次输入的大小一致
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%获得图片格式
picname=strcat('*.',picformat);
%显示该目录下的该图片格式的所有图片,此处如使用ls,ls所得的结果是字符数组,对下一步无法更好操作
picname=dir(picname);
%使用avifile,可进行很多参数的设定修改
aviobj = avifile(aviname);
% aviobj = avifile('test.avi')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%可调整的参数
% Adjustable parameters:
%                Fps: 15.0000
%        Compression: 'Indeo5'
%            Quality: 75
%     KeyFramePerSec: 2.1429
%          VideoName: 'test.avi'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
%%自动获得的参数
% Automatically updated parameters:
%         Filename: 'test.avi'
%      TotalFrames: 0
%            Width: 0
%           Height: 0
%           Length: 0
%        ImageType: 'Unknown'
%     CurrentState: 'Open'
%%%%%%%%%%%%%%%%%%%%%%%
aviobj.Quality = 100;
aviobj.compression='None';
%使用addframe把图片写入视频
for i=picfrom:picend
    picdata=imread((picname(i,1).name));
    aviobj=addframe(aviobj,uint8(picdata)); 

end
aviobj=close(aviobj);