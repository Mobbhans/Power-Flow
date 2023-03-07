function [Y,Yd] =YMatrix(Data)
%����ڵ㵼�ɾ���
j = 1i ; 
n = Data.SysPara.Bus;
%% ��·����

LineG = Data.Line.R ./ (Data.Line.R.^2 + Data.Line.X.^2);
LineB = -Data.Line.X ./ (Data.Line.R.^2 + Data.Line.X.^2);
YLine = LineG + j*LineB ;
Yd.Yline = YLine ; 

%% ��ѹ������

TransG = Data.Trans.R ./ (Data.Trans.R.^2 + Data.Trans.X.^2);
TransB = -Data.Trans.X ./ (Data.Trans.R.^2 + Data.Trans.X.^2);
YTrans = TransG + j*TransB ;    
Yd.YTrans = YTrans ;

%% �γ�Y��
%��ԭչʾ�Ļ������޸ı�ѹ�����㷽ʽ 
% |yii, yij|    |k^2, -k|
% |        |   =|       |    * YTrans 
% |yji, yjj|    |-k,   1|

Yij = - ( sparse(Data.Line.Busi,Data.Line.Busj,YLine,n,n) + sparse(Data.Trans.Busi,Data.Trans.Busj,YTrans./Data.Trans.K,n,n) );  %���㻥����
Yij = Yij + Yij.' ;

YiiLine = sparse([Data.Line.Busi;Data.Line.Busj],[Data.Line.Busi;Data.Line.Busj],[YLine;YLine] + j*[Data.Line.B;Data.Line.B],n,n)  ;  %��·�Ե���

YiiGround = sparse(Data.Ground.Bus,Data.Ground.Bus,j*Data.Ground.B,n,n);   %�ӵ�֧·�Ե���

YiiTrans = sparse(Data.Trans.Busi,Data.Trans.Busi,YTrans./(Data.Trans.K.^2),n,n) + ...      %��ѹ��֧·�Ե���
           sparse(Data.Trans.Busj,Data.Trans.Busj,YTrans,n,n);
       
 Yii = YiiLine + YiiGround + YiiTrans;
 
 Y = Yii + Yij ; 

end

