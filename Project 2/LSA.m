% xa, ya, IOP = [xp, yp, c] num_GCP=length(xa), dist=[k1,k2,k3,p1,p2,p3]
IOP = rand(3,1);
dist = rand(6,1);
xa = [];
ya = [];
num_GCP = length(xa);
xp = IOP(1);
yp = IOP(2);
 c = IOP(3);

while False
    
    % OAX, OAY, OAZ
    
    % calculate A_50x6 (num_GCP,c,OAX,OAY,OAZ,omega,phi,kappa)
    [A,Nx,Ny,D] = calc_A(num_GCP, c, OAX, OAY, OAZ, omega, phi, kappa);
    
    % calculate y_50x1 (dist,xa,ya,xp,yp,c,Nx_mat,Ny_mat,D_mat)
    y = calc_y(dist,xa,ya,xp,yp,c,Nx,Ny,D);
    
    % calculate x_hat
    P = eye(50);
    x_hat = inv(A'*P*A)*A'*P*y;
    
    % update EOPs
    omega = 
end
    