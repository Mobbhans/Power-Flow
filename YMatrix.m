function [Y,Yd] =YMatrix(Data)
%计算节点导纳矩阵
j = 1i ; 
n = Data.SysPara.Bus;
%% 线路导纳

LineG = Data.Line.R ./ (Data.Line.R.^2 + Data.Line.X.^2);
LineB = -Data.Line.X ./ (Data.Line.R.^2 + Data.Line.X.^2);
YLine = LineG + j*LineB ;
Yd.Yline = YLine ; 

%% 变压器导纳

TransG = Data.Trans.R ./ (Data.Trans.R.^2 + Data.Trans.X.^2);
TransB = -Data.Trans.X ./ (Data.Trans.R.^2 + Data.Trans.X.^2);
YTrans = TransG + j*TransB ;    
Yd.YTrans = YTrans ;

%% 形成Y阵
%在原展示的基础上修改变压器计算方式 
% |yii, yij|    |k^2, -k|
% |        |   =|       |    * YTrans 
% |yji, yjj|    |-k,   1|

Yij = - ( sparse(Data.Line.Busi,Data.Line.Busj,YLine,n,n) + sparse(Data.Trans.Busi,Data.Trans.Busj,YTrans./Data.Trans.K,n,n) );  %计算互导纳
Yij = Yij + Yij.' ;

YiiLine = sparse([Data.Line.Busi;Data.Line.Busj],[Data.Line.Busi;Data.Line.Busj],[YLine;YLine] + j*[Data.Line.B;Data.Line.B],n,n)  ;  %线路自导纳

YiiGround = sparse(Data.Ground.Bus,Data.Ground.Bus,j*Data.Ground.B,n,n);   %接地支路自导纳

YiiTrans = sparse(Data.Trans.Busi,Data.Trans.Busi,YTrans./(Data.Trans.K.^2),n,n) + ...      %变压器支路自导纳
           sparse(Data.Trans.Busj,Data.Trans.Busj,YTrans,n,n);
       
 Yii = YiiLine + YiiGround + YiiTrans;
 
 Y = Yii + Yij ; 

end

