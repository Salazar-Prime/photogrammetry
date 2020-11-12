function [xa,ya] = remove_dist(xa,ya,dist)

% unpack distortion parameters
k1 = dist(1);
k2 = dist(2);
k3 = dist(3);
p1 = dist(4);
p2 = dist(5);
p3 = dist(6);

% calculate x_bar, y_bar, r
r = sqrt(xa.^2 + ya.^2);

% calculate delta_xr, delta_yr - radial distortion
delta_xr =  xa .* (k1*r.^2 + k2*r.^4 + k3*r.^6);
delta_yr =  ya .* (k1*r.^2 + k2*r.^4 + k3*r.^6);

% calculate delta_xd, delta_yd - de-centering lens distortion
delta_xd = (1+p3*r.^2).*(p1*(r.^2 + 2*xa.^2) + 2*p2*xa.*ya);
delta_yd = (1+p3*r.^2).*(2*p1*xa.*ya + p2*(r.^2 + 2*ya.^2));

% remove distortions
xa = xa - delta_xr - delta_xd;
ya = ya - delta_yr - delta_yd;

end