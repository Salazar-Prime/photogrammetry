function [X0,Y0,Z0,omega,phi,kappa]=assign_EOP(EOP)
       X0 = EOP(1);
       Y0 = EOP(2);
       Z0 = EOP(3);
    omega = EOP(4);
      phi = EOP(5);
    kappa = EOP(6);
end