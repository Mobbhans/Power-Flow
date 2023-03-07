function [] = PowerFlow()
%% 
%   作者：黄圣权
%   日期：2023.02.20
%% 主函数
    clc;
    clear;
    [Data,V] = ReadData();     %读数据
    [Y,Yd] = YMatrix(Data);  %形成节点导纳矩阵
    k = 0;
    disp("迭代次数  最大Deta")
    while k<=Data.SysPara.KMax                        %迭代过程
        [Deta_P,Deta_Q,Deta_Max]=Unblance(Data,V,Y);  %计算不平衡量
        Lameda(k+1) = Deta_Max ;
        fprintf("%5d%11.4f\n",k,full(Deta_Max))
        if max( Deta_Max )  >  Data.SysPara.Precision
            J = Jacobi(Data,V,Y) ;                    %计算Jacobi矩阵
            [Deta_V,Deta_D] = Solve(Deta_P,Deta_Q,J,Data);       %求解修正量 
            V = Update(V,Deta_V,Deta_D) ;                        %更新数据
        else
            fprintf("计算成功，迭代次数为%d\n",k)
            break;   
        end
        k=k+1 ;
    end
    Solution(Data,V,Lameda,k);                                    %展示结果
    [S_slack,Sij,Sji,S_loss] = LinePower(Data,V,Yd,Y);
    fprintf("平衡节点功率为：")
    disp(S_slack)
    toc
end




