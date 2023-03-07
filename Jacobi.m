function [Ja] = Jacobi(Data,V,Y)
%计算雅可比矩阵

D_new = sparse( repmat(angle(V), [1, Data.SysPara.Bus]) - repmat(angle(V)', [Data.SysPara.Bus, 1]) - angle(Y) );

Y_abs = abs(Y) ;
V_abs = abs(V) ;


N = sparse( diag(V_abs) * Y_abs .* cos(D_new) + diag( Y_abs .* cos(D_new) * V_abs ) ) ; 
H = sparse( diag(V_abs) * ( Y_abs .* sin(D_new) * diag(V_abs) - diag( Y_abs .* sin(D_new) * V_abs ) ) )  ;

L = sparse( diag(V_abs) * Y_abs .* sin(D_new) + diag( Y_abs .* sin(D_new) * V_abs ) ) ;
J = sparse( diag(V_abs) * ( diag( Y_abs .* cos(D_new) * V_abs ) - Y_abs .* cos(D_new) * diag(V_abs) ) )  ; 

Ja = sparse([H,N;J,L]) ;
%% 置零调整
%平衡节点置零和其对角置一

Ja(Data.SysPara.Slack,:) = 0  ;
Ja(Data.SysPara.Bus + Data.SysPara.Slack,:) = 0 ;
Ja(:,Data.SysPara.Slack) = 0  ;
Ja(:,Data.SysPara.Bus + Data.SysPara.Slack) = 0 ;

Ja(Data.SysPara.Slack,Data.SysPara.Slack) = 1 ; 
Ja(Data.SysPara.Bus + Data.SysPara.Slack , Data.SysPara.Bus + Data.SysPara.Slack) = 1 ; 

%PV节点置零和其对角置一

Ja(Data.SysPara.Bus +Data.PV.Bus,:)=0 ;
Ja = Ja + sparse( Data.SysPara.Bus + Data.PV.Bus ,Data.SysPara.Bus + Data.PV.Bus ,1 , 2*Data.SysPara.Bus,2*Data.SysPara.Bus) ;

end

