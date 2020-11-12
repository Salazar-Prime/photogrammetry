function [A] = calc_A(num_GCP,XA,YA,xa,ya)

% create an empty A matrix 
A = zeros(num_GCP*2,8);

% loop over all ground control points
for i=1:num_GCP
    
    A(2*i-1,:) = [XA(i),YA(i),1, 0,0,0, -1*xa(i)*XA(i), -1*xa(i)*YA(i)];
    A(2*i,  :) = [0,0,0, XA(i),YA(i),1, -1*ya(i)*XA(i), -1*ya(i)*YA(i)];
    
end
