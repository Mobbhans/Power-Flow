function [Deta_P,Deta_Q,Deta_Max] =Unblance(Data,V,Y)

%% ���㲻ƽ����

S = sparse( diag(V) * conj(Y*V) ) ;
Deta_P = Data.RunPara.PG - Data.RunPara.PL - real(S) ;
Deta_Q = Data.RunPara.QG - Data.RunPara.QL - imag(S) ;

%% ����ƽ��ڵ�

Deta_P(Data.SysPara.Slack) = 0 ;
Deta_Q(Data.SysPara.Slack) = 0 ;

%% ����PV�ڵ�

Deta_Q(Data.PV.Bus) = 0 ;

%% ϡ�軯

Deta_P = sparse(Deta_P);
Deta_Q = sparse(Deta_Q);

%% �����ƽ����

Deta_Max = max( abs([Deta_P;Deta_Q]) ) ;

end


