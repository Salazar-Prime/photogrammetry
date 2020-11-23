function [S] = calc_S(num_GCP,xa,ya,xp,yp,c,XA,YA,ZA,X0,Y0,Z0)

S = zeros(4,4);
for i=1:num_GCP
    xi = [0,xa(i),ya(i),-c];
    xi  = xi/norm(xi);
    Xi = [0,XA(i)-X0,YA(i)-Y0,ZA(i)-Z0];
    Xi = Xi/norm(Xi);
    
    mat1 = [xi(1),-xi(2),-xi(3),-xi(4);
            xi(2), xi(1), xi(4),-xi(3);
            xi(3),-xi(4), xi(1), xi(2);
            xi(4), xi(3),-xi(2), xi(1)];
    mat2 = [Xi(1),-Xi(2),-Xi(3),-Xi(4);
            Xi(2), Xi(1),-Xi(4), Xi(3);
            Xi(3), Xi(4), Xi(1),-Xi(2);
            Xi(4),-Xi(3), Xi(2), Xi(1)];
    S = S + mat1'*mat2;
    trace(mat1*mat2)
end
end