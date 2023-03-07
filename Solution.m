function [] = Solution(Data,V,Lameda,k)
%��ʾ���
%% �ж��Ƿ����ʧ��
if k > Data.SysPara.KMax
    disp("���㲻����")
    return
end
%% ��ʾ��ѹ��ֵ�����

Bus = (1:Data.SysPara.Bus)' ; 
V_abs = abs(V) ;
V_angle= angle(V) * (180/pi) ;
disp("����������ʾ")
disp(table(Bus,V_abs,V_angle))


%% ��������
figure(1);
plot(0:length(Lameda) - 1, log(Lameda), 'b--o');
hold on;
grid on;
set(gca,'XTick',0:1:length(Lameda));
title('��������');
xlabel('k')
ylabel('��ƽ�����ݼ�')

%% ��ѹ����
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
title('��ѹ����');
xlabel('�ڵ�')
ylabel('��ѹֵ')

end

