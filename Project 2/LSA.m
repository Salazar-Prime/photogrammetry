% xa, ya, num_GCP=length(xa)
xa = [];
ya = [];
num_GCP = length(xa);
c = 0;
while False
    
    % calculate A (num_GCP,c,OAX,OAY,OAZ,omega,phi,kappa)
    A = calc_A(num_GCP, c, OAX, OAY, OAZ, omega, phi, kappa);
        
end
    