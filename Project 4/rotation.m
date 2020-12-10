function [rot]=rotation(omega, phi, kappa)

rot_o = [1 0 0; 0 cosd(omega) -sind(omega); 0 sind(omega) cosd(omega)];
rot_p = [cosd(phi) 0 sind(phi); 0 1 0; -sind(phi) 0 cosd(phi)];
rot_k = [cosd(kappa) -sind(kappa) 0; sind(kappa) cosd(kappa) 0; 0 0 1];

rot = rot_o * rot_p * rot_k;

end
