% Programmed by Eui Myoung Kim
% Date : 2017. 09. 06
% Unit : IOP(mm), EOP(deg, meter)
% This program is for displaying camera w.r.t ground coordinate systems
% Procedure -------------------------------------------------------------
% Program name : drawCameras.m
% 1. read input files(cam_info, EOP, GCP)
% 2. draw camera position
% 3. draw ground control points
%------------------------------------------------------------------------
% recall:
%   R_Rotation.m
%   drawCameras.m
%

% IOP[pixelsize, img_width, img_height, xp, yp, foc]
% EOP(w, p, k, Xo, Yo, Zo)
function [] = drawCameras(imgId, scale, IOP, EOP)
    
% mm to meter
pixelsize = IOP(1)/1000;
row = IOP(2);
col = IOP(3);
foc = IOP(6)/1000;

% exaggeration for visualizaion
foc = foc*scale;
pixelsize = pixelsize*scale;

% boundary in photo coordinate system
img_bnd(:,1) = [-col*pixelsize/2;  row*pixelsize/2; -foc];
img_bnd(:,2) = [-col*pixelsize/2; -row*pixelsize/2; -foc];
img_bnd(:,3) = [ col*pixelsize/2; -row*pixelsize/2; -foc];
img_bnd(:,4) = [ col*pixelsize/2;  row*pixelsize/2; -foc];

% crossing lines in photo coordinate system
cross_line(:,1) = [ 0;  row*pixelsize/2; -foc];
cross_line(:,2) = [ 0; -row*pixelsize/2; -foc];
cross_line(:,3) = [ -col*pixelsize/2; 0; -foc];
cross_line(:,4) = [  col*pixelsize/2; 0; -foc];

% rotation matrix (R_camera_to_mapping)
omega = EOP(1) * pi / 180;
phi = EOP(2) * pi / 180;
kappa = EOP(3) * pi / 180;

R_c_m = R_Rotation(omega, phi, kappa);%rotation camera w.r.t mapping

exposure_station = EOP(4:6)';

% calculate camera axis
xc = exposure_station + R_c_m*[col*pixelsize*1.2; 0; 0];
yc = exposure_station + R_c_m*[0; row*pixelsize*1.2; 0];
zc = exposure_station + R_c_m*[0; 0; foc];% use foc instead of -foc

% Optical axis in object coordiante system
camera_x_axis = [exposure_station xc];
camera_y_axis = [exposure_station yc];
camera_z_axis = [exposure_station zc];

% photo boundary transformation
bnd_obj = zeros(3,5);
cr_obj = zeros(3,4);    
for i=1:4
    bnd_obj(:,i) = exposure_station + R_c_m*img_bnd(:,i);
    cr_obj(:,i) = exposure_station + R_c_m*cross_line(:,i);
end
bnd_obj(:,5) = exposure_station + R_c_m*img_bnd(:,1);

hold on;

% perspective center
plot3(EOP(4),EOP(5),EOP(6),'c.','LineWidth',1);

% photo boundaries
plot3(bnd_obj(1,:),bnd_obj(2,:),bnd_obj(3,:),'c-','LineWidth',1);

% perspective center and photo boundaries
for i=1:4
    plot3([bnd_obj(1,i);EOP(4)],[bnd_obj(2,i);EOP(5)],...
          [bnd_obj(3,i);EOP(6)],'c-','LineWidth',0.5);
end

% %crossing lines
% plot3(cr_obj(1,1:2),cr_obj(2,1:2),cr_obj(3,1:2),'c-','LineWidth',1);
% plot3(cr_obj(1,3:4),cr_obj(2,3:4),cr_obj(3,3:4),'c-','LineWidth',1); 

% draw camera axis w.r.t mapping coordinate system


plot3(camera_x_axis(1,:),camera_x_axis(2,:),camera_x_axis(3,:),'r-','LineWidth',2);%red X
plot3(camera_y_axis(1,:),camera_y_axis(2,:),camera_y_axis(3,:),'g-','LineWidth',2);%green Y
plot3(camera_z_axis(1,:),camera_z_axis(2,:),camera_z_axis(3,:),'b-','LineWidth',2);%blue Z

%legend([camera_x_axis, camera_y_axis, camera_z_axis],'camera_x_axis', 'camera_y_axis', 'camera_z_axis', 'Location', 'northeast');

% draw cameraid
Xo = EOP(4);
Yo = EOP(5);
Zo = EOP(6) + 0.1;

text(Xo,Yo,Zo,imgId,'FontSize',8,'Color','magenta');
    
