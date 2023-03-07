function [S_slack,Sij,Sji,S_loss] = LinePower(Data,V,Yd,Y)
% 计算平衡节点功率、线路功率和线损
S_slack = V(Data.SysPara.Slack) * conj( Y(Data.SysPara.Slack,:) * V )  ;

%% 线路功率
i = [Data.Line.Busi;Data.Trans.Busi];
j = [Data.Line.Busj;Data.Trans.Busj];
yi0 = [1j * Data.Line.B; (1 - Data.Trans.K) .* Yd.YTrans ./ Data.Trans.K.^2 ];
yj0 = [1j * Data.Line.B; ( Data.Trans.K - 1) .* Yd.YTrans ./ Data.Trans.K ]; 
yij = [Yd.Yline;Yd.YTrans ./ Data.Trans.K] ;

Sij = V(i) .* conj(V(i).* yi0 + (V(i)-V(j)) .* yij );
Sji = V(j) .* conj(V(j).* yj0 + (V(j)-V(i)) .* yij );

S_loss = Sij + Sji ; 





end

