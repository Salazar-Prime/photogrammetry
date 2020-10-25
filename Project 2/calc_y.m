function [y] = calc_y(dist,xa,ya,xp,yp,c,Nx,Ny,D)

%% calculate x_corr and y_corr

% unpack distortion parameters
k1 = dist(1);
k2 = dist(1);
k3 = dist(1);
p1 = dist(1);
p2 = dist(1);
p3 = dist(1);

% calculate x_bar, y_bar, r
x_bar = xa - xp;
y_bar = ya - yp;
r = sqrt(x_bar.^2 + y_bar.^2);

% calculate delta_xr, delta_yr - radial distortion
delta_xr =  x_bar .* (k1*r.^2 + k2*r.^4 + k3*r.^6);
delta_yr =  y_bar .* (k1*r.^2 + k2*r.^4 + k3*r.^6);

% calculate delta_xd, delta_yd - de-centering lens distortion
delta_xd = (1+p3*r.^2).*(p1*(r.^2 + 2*x_bar.^2) + 2*p2*x_bar.*y_bar);
delta_yd = (1+p3*r.^2).*(2*p1*x_bar.*y_bar + p2*(r.^2 + 2*y_bar.^2));

% calculate x_corr, y_corr
x_corr = delta_xr - delta_xd;
y_corr = delta_yr - delta_yd;

%% calcualte y

x_corr = x_corr - (xp - c*Nx./D);
y_corr = y_corr - (yp - c*Ny./D);

% alternate merge in order : x_corr and y_corr
y = [x_corr y_corr]';
y = y(:);

end