%% function to calculate linear intersection
function [XI,YI,ZI] = linear_intersection(EOP_L,EOP_R,IOP,dist,xal,yal,xar,yar)

% initialize varibles
num_GCP = length(xal);
lambda = zeros(num_GCP,1);
mew = zeros(num_GCP,1);
XI = zeros(num_GCP,1);
YI = zeros(num_GCP,1);
ZI = zeros(num_GCP,1);

% unpack IOP and EOP
[xp,yp,c]=assign_IOP(IOP);
[X0l,Y0l,Z0l,omegal,phil,kappal] = assign_EOP(EOP_L);
[X0r,Y0r,Z0r,omegar,phir,kappar] = assign_EOP(EOP_R);

% remove image distortion
[xal,yal] = remove_dist(xal,yal,dist,xp,yp);
[xar,yar] = remove_dist(xar,yar,dist,xp,yp);

% get rotation matrices
rot_l = rotation(omegal,phil,kappal);
rot_r = rotation(omegar,phir,kappar);

% LHS of equation
LHS = [X0r-X0l;Y0r-Y0l;Z0r-Z0l];

% for each point calculate lambda and mew
for i=1:num_GCP
    % RHS of equation
    RHS = [rot_l*[xal(i),yal(i),-c]',-1*rot_r*[xar(i),yar(i),-c]'];
    temp = inv(RHS'*RHS)*RHS'*LHS;
    lambda(i) = temp(1);
    mew(i) = temp(2);
end

% XI , YI, ZI
for i=1:num_GCP
    RHS1 = rot_l*[xal(i),yal(i),-c]';
    RHS2 = rot_r*[xar(i),yar(i),-c]';
    XI(i) = ( (X0l + lambda(i)*RHS1(1)) + (X0r + mew(i)*RHS2(1)) )/2;
    YI(i) = ( (Y0l + lambda(i)*RHS1(2)) + (Y0r + mew(i)*RHS2(2)) )/2;
    ZI(i) = ( (Z0l + lambda(i)*RHS1(3)) + (Z0r + mew(i)*RHS2(3)) )/2;
end

end