function [c,EOP] = LSA(xa,ya,XA,YA,ZA,IOP,dist)
%% parameters
num_GCP = length(xa);

% Unpack IOPs
[xp,yp,~] = assign_IOP(IOP);

%% A and y matrix
[xa,ya] = remove_dist(xa,ya,dist,xp,yp);
[A] = calc_A(num_GCP,xa,ya,XA,YA);
[y] = calc_y(xa,ya);

%% calculate x_hat 

[C1,C2,C3,C4,C5,C6,C7,C8] = calc_x_hat(A,y);

%% debug residuals
% debug(C1,C2,C3,C4,C5,C6,C7,C8,xa,ya,XA,YA);
%% calculate c 
c = sqrt(-1 * (C1*C2+C4*C5)/(C7*C8));
if not(isreal(c))
    c = 8.1671200690; 
end
%% calculate A'*A
A = [C1,C4,C7;C2,C5,C8;C3,C6,1]*[1,0,0;0,1,0;0,0,c*c]*[C1,C2,C3;C4,C5,C6;C7,C8,1];

%% calculate EOP (X0,Y0,Z0)
X0 = - A(1,3)/A(1,1);
Y0 = - A(2,3)/A(1,1);
Z0 = sqrt(A(3,3)/A(1,1) - X0^2 - Y0^2);

%% calculate EOP (omega,phi,kappa)
S = calc_S(num_GCP,xa,ya,xp,yp,c,XA,YA,ZA,X0,Y0,Z0);
[omega,phi,kappa] = calc_opk(S);
EOP = [X0,Y0,Z0,rad2deg(omega),rad2deg(phi),rad2deg(kappa)];
end


    