function [V] = Update(V,Deta_V,Deta_D)
%更新数据

V_abs = abs(V) + Deta_V ; 
V_angle = angle(V) + Deta_D ;

V = V_abs .* ( cos(V_angle) + 1j * sin(V_angle) );


end

