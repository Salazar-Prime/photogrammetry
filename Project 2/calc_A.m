function [A] = calc_A(num_GCP,c,OAX,OAY,OAZ,kappa)

%% calcualte rotation
r = rotation(omega,phi,kappa);

%% calculate N and D (OAX,OAY,OAZ,rot)
Nx_mat = r(1,1)*OAX + r(2,1)*OAY + r(3,1)*OAZ;
Ny_mat = r(1,2)*OAX + r(2,2)*OAY + r(3,2)*OAZ;
 D_mat = r(1,3)*OAX + r(2,3)*OAY + r(3,3)*OAZ;
 
%% calculate aij, bij

% create an empty A matrix 
A = zeros(num_GCP*2,6);

% loop over all ground control points
for i=1:num_GCP
    
    % Nx, Ny, D for ith GCP
    Nx = Nx_mat(i);
    Ny = Ny_mat(i);
     D =  D_mat(i);
     
    % aij for ith GCP
    a1 = r(1,1)*D - r(1,3)*Nx;
    a2 = r(2,1)*D - r(2,3)*Nx;
    a3 = r(3,1)*D - r(3,3)*Nx;
    a4 = D*(r(3,1)*OAY(i) - r(2,1)*OAZ(i)) + Nx*(r(2,3)*OAZ(i) - r(3,3)*OAY(i));
    a5 = D*D*cos(kappa) - Nx*(-Nx*cos(kappa) + Ny*sin(kappa));
    a6 = -1 * Ny/D;
    
    % bij for ith GCP
    b1 = r(1,2)*D - r(1,3)*Ny;
    b2 = r(2,2)*D - r(2,3)*Ny;
    b3 = r(3,2)*D - r(3,3)*Ny;
    b4 = D*(r(3,2)*OAY(i) - r(2,2)*OAZ(i)) + Ny*(r(2,3)*OAZ(i) - r(3,3)*OAY(i));
    b5 = -1*D*D*sin(kappa) - Ny*(-Nx*cos(kappa) + Ny*sin(kappa));
    b6 = Nx/D;
    
    % multipling by c/D^2 before appending into A
    A(2i-1,:) = [a1,a2,a3,a4,a5,a6]*c/D^2;
      A(2i,:) = [b1,b2,b3,b4,b5,b6]*c/D^2;
    
end
