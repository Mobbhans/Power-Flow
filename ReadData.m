function [Data,V] = ReadData()
%% 读数据
[FileName, path, indx] = uigetfile(...
        {'*.dat; *.txt; *.xlsx', 'Data Files(*.dat, *.txt, *.xlsx)';...
        '*.*', 'All Files (*.*)'},...
        'Select an icon file','IEEE4.dat');
tic ;     
AllData = dlmread(FileName);
Zero = find(AllData(:,1)==0);

%% 系统参数

Data.SysPara.Bus = AllData(1,1);
Data.SysPara.Line = AllData(1,2);
Data.SysPara.Base = AllData(1,3);
Data.SysPara.KMax = AllData(1,4);
Data.SysPara.Precision = AllData(2,1);
Data.SysPara.Slack = AllData(3,2);

%% 线路参数

LineData = AllData(Zero(1)+1:Zero(2)-1,:);
Data.Line.BusN = LineData(:,1);
Data.Line.Busi = LineData(:,2);
Data.Line.Busj = LineData(:,3);
Data.Line.R = LineData(:,4);
Data.Line.X = LineData(:,5);
Data.Line.B = LineData(:,6);

%% 接地支路参数

GroundData = AllData(Zero(2)+1:Zero(3)-1,:);
Data.Ground.Bus = GroundData(:,1);
Data.Ground.B = GroundData(:,2);

%% 变压器参数

TransData = AllData(Zero(3)+1:Zero(4)-1,:);
Data.Trans.BusN = TransData(:,1);
Data.Trans.Busi = TransData(:,2);
Data.Trans.Busj = TransData(:,3);
Data.Trans.R = TransData(:,4);
Data.Trans.X = TransData(:,5);
Data.Trans.K = TransData(:,6);

%% 运行参数

RunData = AllData(Zero(4)+1:Zero(5)-1,:);
RunData = sortrows(RunData, 1);    %注意排序，不排序会出错
Data.RunPara.Bus = RunData(:,1);
Data.RunPara.PG = RunData(:,2) / Data.SysPara.Base ;
Data.RunPara.QG = RunData(:,3) / Data.SysPara.Base;
Data.RunPara.PL = RunData(:,4) / Data.SysPara.Base;
Data.RunPara.QL = RunData(:,5) / Data.SysPara.Base;

%% PV节点参数

PVData = AllData(Zero(5)+1:Zero(6)-1,:);
Data.PV.Bus = PVData(:,1);
Data.PV.V = PVData(:,2);
Data.PV.Ql = PVData(:,3);
Data.PV.Qu = PVData(:,4);


%% 平启动参数

V = ones(Data.SysPara.Bus,1);
V(Data.PV.Bus) = Data.PV.V ;

end


