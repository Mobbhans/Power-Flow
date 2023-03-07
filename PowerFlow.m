function [] = PowerFlow()
%% 
%   ���ߣ���ʥȨ
%   ���ڣ�2023.02.20
%% ������
    clc;
    clear;
    [Data,V] = ReadData();     %������
    [Y,Yd] = YMatrix(Data);  %�γɽڵ㵼�ɾ���
    k = 0;
    disp("��������  ���Deta")
    while k<=Data.SysPara.KMax                        %��������
        [Deta_P,Deta_Q,Deta_Max]=Unblance(Data,V,Y);  %���㲻ƽ����
        Lameda(k+1) = Deta_Max ;
        fprintf("%5d%11.4f\n",k,full(Deta_Max))
        if max( Deta_Max )  >  Data.SysPara.Precision
            J = Jacobi(Data,V,Y) ;                    %����Jacobi����
            [Deta_V,Deta_D] = Solve(Deta_P,Deta_Q,J,Data);       %��������� 
            V = Update(V,Deta_V,Deta_D) ;                        %��������
        else
            fprintf("����ɹ�����������Ϊ%d\n",k)
            break;   
        end
        k=k+1 ;
    end
    Solution(Data,V,Lameda,k);                                    %չʾ���
    [S_slack,Sij,Sji,S_loss] = LinePower(Data,V,Yd,Y);
    fprintf("ƽ��ڵ㹦��Ϊ��")
    disp(S_slack)
    toc
end




