function [X0,Y0,Z0,omega,phi,kappa]=update_EOP(x_hat)
       X0 = x_hat(1);
       Y0 = x_hat(2);
       Z0 = x_hat(3);
    omega = x_hat(4);
      phi = x_hat(5);
    kappa = x_hat(6);
end