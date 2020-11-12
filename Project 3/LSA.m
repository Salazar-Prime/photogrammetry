function [EOP,e,sigma_hat,iter,D,EOP_history] = LSA(xa,ya,XA,YA,ZA,IOP,dist,EOP)
%% parameters
% max_iter = 10000;
% thres = 1e-8;
% sigma_hat = 0;
num_GCP = length(xa);

% Unpack EOPs and IOPs
% [X0,Y0,Z0,omega,phi,kappa] = update_EOP(EOP, zeros(6,1));
% [xp,yp,c] = assign_IOP(IOP);
% EOP_history = EOP;

%% A and y matrix
xa,ya = remove_dist(xa,ya,dist);
A = calc_A(num_GCP,xa,ya,XA,YA);
y = calc_y(xa,ya);

%% calculate x_hat 
x_hat = (A'*A)\A'*y;
[C1,C2,C3,C4,C5,C6,C7,C8] = matsplit(x_hat);

%% calculate c 
c = sqrt(-1 * (C1*C2+C4*C5)/(C7*C8));

%% calculate A'*A
A = [C1,C4,C7;C2,C5,C8;C3,C6,1]*[1,0,0;0,1,0;0,0,c*c]*[C1,C2,C3;C4,C5,C6;C7,C8,1];

%% calculate EOP (X0,Y0,Z0)
X0 = - A(1,3)/A(1,1);
Y0 = - A(2,3)/A(1,1);
Z0 = sqrt(A(3,3)/A(1,1) - X0^2 - Y0^2);

%% calculate EOP (omega,phi,kappa)

%% LSA iterations
% for iter=1:max_iter
%     
%     % update sigma_hat_prev 
%     sigma_hat_prev = sigma_hat;
%     
%     % OAX, OAY, OAZ
%     OAX = XA - X0;
%     OAY = YA - Y0;
%     OAZ = ZA - Z0;
%     
%     % calculate A_50x6 (num_GCP,c,OAX,OAY,OAZ,omega,phi,kappa)
%     [A,Nx,Ny,D] = calc_A(num_GCP, c, OAX, OAY, OAZ, omega, phi, kappa);
%     
%     % calculate y_50x1 (dist,xa,ya,xp,yp,c,Nx_mat,Ny_mat,D_mat)
%     y = calc_y(dist,xa,ya,xp,yp,c,Nx,Ny,D);
%     
%     % calculate x_hat
%     P = eye(num_GCP*2);
%     x_hat = inv(A'*P*A)*A'*P*y;
%     
%     % update EOPs
%     [X0,Y0,Z0,omega,phi,kappa,EOP] = update_EOP(EOP, x_hat);
%     EOP_history = [EOP_history;EOP]
%     
%     % calculate e and sigma_hat
%     e = y - A*x_hat;
%     sigma_hat = (e'*P*e)/(num_GCP - length(x_hat));
%     
%     % break out of loop is threshold is reached
%     if abs(sigma_hat - sigma_hat_prev) < thres
%           D = sigma_hat*inv(A'*P*A);
%           e = [e(1:2:end),e(2:2:end)];
%         EOP = [X0,Y0,Z0,rad2deg(omega),rad2deg(phi),rad2deg(kappa)];      
%         break
%     end
    
end


    