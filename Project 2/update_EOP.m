function [X0,Y0,Z0,omega,phi,kappa,EOP]=update_EOP(EOP, x_hat)
       X0 = EOP(1) + x_hat(1);
       Y0 = EOP(2) + x_hat(2);
       Z0 = EOP(3) + x_hat(3);
    omega = EOP(4) + x_hat(4);
      phi = EOP(5) + x_hat(5);
    kappa = EOP(6) + x_hat(6);
    EOP = [X0,Y0,Z0,omega,phi,kappa];
end