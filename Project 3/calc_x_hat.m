function [C1,C2,C3,C4,C5,C6,C7,C8] = calc_x_hat(A,y)

x_hat = inv(A'*A)*A'*y;
C1 = x_hat(1);
C2 = x_hat(2);
C3 = x_hat(3);
C4 = x_hat(4);
C5 = x_hat(5);
C6 = x_hat(6);
C7 = x_hat(7);
C8 = x_hat(8);

end