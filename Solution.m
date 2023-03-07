function [] = Solution(Data,V,Lameda,k)
%显示结果
%% 判断是否计算失败
if k > Data.SysPara.KMax
    disp("计算不收敛")
    return
end
%% 显示电压幅值和相角

Bus = (1:Data.SysPara.Bus)' ; 
V_abs = abs(V) ;
V_angle= angle(V) * (180/pi) ;
disp("数据如下所示")
disp(table(Bus,V_abs,V_angle))


%% 收敛曲线
figure(1);
plot(0:length(Lameda) - 1, log(Lameda), 'b--o');
hold on;
grid on;
set(gca,'XTick',0:1:length(Lameda));
title('收敛曲线');
xlabel('k')
ylabel('不平衡量幂级')

%% 电压曲线
figure(2);
lamda = 0.05;
line([0, Data.SysPara.Bus], [1 - lamda, 1 - lamda], 'linestyle', '--', 'color', 'red');
hold on;
line([0,Data.SysPara.Bus], [1 + lamda, 1 + lamda], 'linestyle', '--', 'color', 'red');
hold on;
plot(1: Data.SysPara.Bus, abs(V), 'b--*')
grid on;
axis([1 Data.SysPara.Bus 1 - lamda * 2, 1 + lamda * 2])
set(gca,'XTick',0:1:Data.SysPara.Bus);
title('电压曲线');
xlabel('节点')
ylabel('电压值')

end

