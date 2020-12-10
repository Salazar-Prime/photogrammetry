%% function to calculate multi intersection
function [XI,YI,ZI] = multi_intersection(EOP1,EOP2,EOP3,EOP4,IOP,dist,xa1,ya1,xa2,ya2,xa3,ya3,xa4,ya4)

% initialize varibles
num_GCP = length(xa1);
XI = zeros(num_GCP,1);
YI = zeros(num_GCP,1);
ZI = zeros(num_GCP,1);

% unpack IOP and EOP
[xp,yp,c]=assign_IOP(IOP);
[X01,Y01,Z01,omega1,phi1,kappa1] = assign_EOP(EOP1);
[X02,Y02,Z02,omega2,phi2,kappa2] = assign_EOP(EOP2);
[X03,Y03,Z03,omega3,phi3,kappa3] = assign_EOP(EOP3);
[X04,Y04,Z04,omega4,phi4,kappa4] = assign_EOP(EOP4);

% remove image distortion
[xa1,ya1] = remove_dist(xa1,ya1,dist,xp,yp);
[xa2,ya2] = remove_dist(xa2,ya2,dist,xp,yp);    
[xa3,ya3] = remove_dist(xa3,ya3,dist,xp,yp);    
[xa4,ya4] = remove_dist(xa4,ya4,dist,xp,yp);    

% get rotation matrices
rot1 = rotation(omega1,phi1,kappa1);
rot2 = rotation(omega2,phi2,kappa2);
rot3 = rotation(omega3,phi3,kappa3);
rot4 = rotation(omega4,phi4,kappa4);

% XI , YI, ZI
for i=1:num_GCP
    RHS1 = rot1*[xa1(i),ya1(i),-c]';
    RHS2 = rot2*[xa2(i),ya2(i),-c]';
    RHS3 = rot3*[xa3(i),ya3(i),-c]';
    RHS4 = rot4*[xa4(i),ya4(i),-c]';
    y = [RHS1(3)*X01-RHS1(1)*Z01;RHS1(3)*Y01-RHS1(2)*Z01;RHS2(3)*X02-RHS2(1)*Z02;RHS2(3)*Y02-RHS2(2)*Z02;RHS3(3)*X03-RHS3(1)*Z03;RHS3(3)*Y03-RHS3(2)*Z03;RHS4(3)*X04-RHS4(1)*Z04;RHS4(3)*Y04-RHS4(2)*Z04];
    A = [RHS1(3),0,-RHS1(1);0,RHS1(3),-RHS1(2);RHS2(3),0,-RHS2(1);0,RHS2(3),-RHS2(2);RHS3(3),0,-RHS3(1);0,RHS3(3),-RHS3(2);RHS4(3),0,-RHS4(1);0,RHS4(3),-RHS4(2)];
    temp = inv(A'*A)*A'*y;
    XI(i) = temp(1);
    YI(i) = temp(2);
    ZI(i) = temp(3);
end

end