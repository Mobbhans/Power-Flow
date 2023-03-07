function [Deta_V,Deta_D] =Solve(Deta_P,Deta_Q,J,Data)
%½âÐÞÕýÁ¿

Deta_VD =  J \  [ Deta_P ; Deta_Q ] ;


Deta_D = Deta_VD(1:Data.SysPara.Bus) ;
Deta_V = Deta_VD(Data.SysPara.Bus+1:2*Data.SysPara.Bus) ;

end

