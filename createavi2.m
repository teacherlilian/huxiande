function CreatAviFromPic(picfrom,picend,picformat,aviname)
%��ͼƬ���ϳ�һ��avi��Ƶ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ʩ���� 2009��01��08��
% ʹ��avifile��addframe��getframe�Ⱥ���ʵ��
% ����: 
%      picfrom��ʼλ��
%      picend��ֹλ��
%      picformatͼƬ��ʽ,���ַ�����
%      aviname����avi������,�������׺��,���ַ�����
%���:��ǰĿ¼��,����Ϊaviname����Ƶ�ļ�
%��ע:����ͼƬ�Ĵ�С�������һ������Ĵ�Сһ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%���ͼƬ��ʽ
picname=strcat('*.',picformat);
%��ʾ��Ŀ¼�µĸ�ͼƬ��ʽ������ͼƬ,�˴���ʹ��ls,ls���õĽ�����ַ�����,����һ���޷����ò���
picname=dir(picname);
%ʹ��avifile,�ɽ��кܶ�������趨�޸�
aviobj = avifile(aviname);
% aviobj = avifile('test.avi')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%�ɵ����Ĳ���
% Adjustable parameters:
%                Fps: 15.0000
%        Compression: 'Indeo5'
%            Quality: 75
%     KeyFramePerSec: 2.1429
%          VideoName: 'test.avi'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
%%�Զ���õĲ���
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
%ʹ��addframe��ͼƬд����Ƶ
for i=picfrom:picend
    picdata=imread((picname(i,1).name));
    aviobj=addframe(aviobj,uint8(picdata)); 

end
aviobj=close(aviobj);