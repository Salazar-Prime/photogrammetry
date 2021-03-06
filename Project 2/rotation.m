function [rot]=rotation(omega, phi, kappa)

rot_o = [1 0 0; 0 cos(omega) -sin(omega); 0 sin(omega) cos(omega)];
rot_p = [cos(phi) 0 sin(phi); 0 1 0; -sin(phi) 0 cos(phi)];
rot_k = [cos(kappa) -sin(kappa) 0; sin(kappa) cos(kappa) 0; 0 0 1];

rot = rot_o * rot_p * rot_k;

end
