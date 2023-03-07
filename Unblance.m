function [Deta_P,Deta_Q,Deta_Max] =Unblance(Data,V,Y)

%% 计算不平衡量

S = sparse( diag(V) * conj(Y*V) ) ;
Deta_P = Data.RunPara.PG - Data.RunPara.PL - real(S) ;
Deta_Q = Data.RunPara.QG - Data.RunPara.QL - imag(S) ;

%% 置零平衡节点

Deta_P(Data.SysPara.Slack) = 0 ;
Deta_Q(Data.SysPara.Slack) = 0 ;

%% 置零PV节点

Deta_Q(Data.PV.Bus) = 0 ;

%% 稀疏化

Deta_P = sparse(Deta_P);
Deta_Q = sparse(Deta_Q);

%% 求最大不平衡量

Deta_Max = max( abs([Deta_P;Deta_Q]) ) ;

end


