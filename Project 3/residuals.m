function [res_x,res_y] = residuals(C1,C2,C3,C4,C5,C6,C7,C8,xa,ya,XA,YA)
    res_x = xa - (C1*XA + C2*YA + C3)./(C7*XA+C8*YA+1);
    res_y = ya - (C4*XA + C5*YA + C6)./(C7*XA+C8*YA+1);
    disp("done debug")
end
