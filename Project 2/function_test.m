
IOP = rand(3,1);
dist = rand(6,1);
xa = rand(25,1);
ya = rand(25,1);
OAX = rand(25,1);
OAY = rand(25,1);
OAZ = rand(25,1);
num_GCP = length(xa);
xp = IOP(1);
yp = IOP(2);
 c = IOP(3);
 
% calculate A (num_GCP,c,OAX,OAY,OAZ,omega,phi,kappa)
[A,Nx,Ny,D] = calc_A(num_GCP,c,OAX,OAY,OAZ,0,pi/4,pi/3);
y = calc_y(dist,xa,ya,xp,yp,c,Nx,Ny,D);