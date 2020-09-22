% Programmed by Eui Myoung Kim
% Date : 2017. 09. 06
% Unit : IOP(mm), EOP(deg, meter)
% This program is for displying camera w.r.t ground coordinate systems
% Procedure -------------------------------------------------------------
% Program name : showCameraWithGCP_main.m
% 1. read input files(cam_info, EOP, GCP)
% 2. draw camera position
% 3. draw ground control points
%------------------------------------------------------------------------
% recall:
%   R_Rotation.m
%   drawCameras.m
%
% input:
%     camera info: Flea_cam_info.txt
%     EOP: eop_msat.icf
%     GCP: Flea_gcp.txt
% 

%close all;
clear all;
clc;


scale = 15.0;%exaggeration(default: 10)

% 1. read input files(cam_info, EOP, GCP)

%% read IOP
[camfile, pathname] = uigetfile('*.txt', 'Please select an iop file(_cam_info.txt)');
camfile = strcat(pathname, camfile);
if pathname == 0
    return;
end

%camfile = 'C:\Matlab_code\2017\Show_cameras\Flea_cam_info.txt';

[camId, pixelsize, img_width, img_height, xp, yp, foc] = textread(camfile,'%s %f %f %f %f %f %f');

IOP = [pixelsize, img_width, img_height, xp, yp, foc];

%% read EOP
[eop_file,pathname] = uigetfile({'*.txt'},'Please Select EOP file(eop.txt)');
eop_file = strcat(pathname,eop_file);
% eop_file = 'C:\Matlab_code\2017\Show_cameras\34_eop_msat.txt';

fin_eop = fopen(eop_file);

%imageId, om, ph, kp, Xo, Yo, Zo
eop = textscan(fin_eop,'%s %f %f %f %f %f %f');
fclose(fin_eop);
neop = length(eop{1});

imageId = eop{1};%imageId
OM = eop{2};
PH = eop{3};
KP = eop{4};
TX = eop{5};
TY = eop{6};
TZ = eop{7};

clear eop;
%disp('Read EOPs');

neop = length(OM);

%% Read GCP
[gcp_file,pathname] = uigetfile({'*.txt';'*.dat';'*.txt'}, 'Please select GCP file(ID X Y Z)');
gcp_file = strcat(pathname, gcp_file);

%gcp_file = 'C:\Matlab_code\2017\Show_cameras\Flea_gcp.txt';

fin_gcp = fopen(gcp_file);
tline = fgetl(fin_gcp);
idx = 1;% index
gcp = {};
while ischar(tline)
    s = regexp(tline,'\s+','split');
    if ((length(s) > 3) && (strncmp(char(s(1)), '!', 1) == 0))
        gcp{idx}.ID = char(s(1));
        gcp{idx}.X = str2double(s(2));
        gcp{idx}.Y = str2double(s(3));
        gcp{idx}.Z = str2double(s(4));
        idx = idx + 1;
    end
    tline = fgetl(fin_gcp);
end
fclose(fin_gcp);
ngcp = length(gcp);% number of gcp

% gcpId = [];
% X = [];
% Y = [];
% Z = [];
% for k=1:ngcp
%     gcpId = gcp{k}.ID;
%     X(idx) = gcp{k}.X;
%     Y(idx) = gcp{k}.Y;
%     Z(idx) = gcp{k}.Z;
% end

msg = sprintf('************************************************************\n');
fprintf(msg);
msg = sprintf('# of Images: %d\n', neop);
fprintf(msg);

% 2. draw camera position
figure;
hold on
axis equal;
grid on;

for i=1:neop
    EOP = [OM(i) PH(i) KP(i) TX(i) TY(i) TZ(i)];%one EOP
    %drawCameras(imageId(i), scale, IOP, EOP);
    id = num2str(i);
    drawCameras(id, scale, IOP, EOP);
end


% 3. draw ground control points
for i=1:ngcp
    id = gcp{i}.ID;
    gx = gcp{i}.X;
    gy = gcp{i}.Y;
    gz = gcp{i}.Z;
    %plot3(gx, gy, gz, 'r.');
    text(gx,gy,gz,id,'FontSize',10,'Color','black');
end

% 4. draw X Y Z axis
X1 = [0.00000000E+00	0.00000000E+00	0.00000000E+00]';
X2 = [2.40156980E+00	0.00000000E+00	0.00000000E+00]';

XC = [X1 X2];

plot3(XC(1,:),XC(2,:),XC(3,:),'k--','LineWidth',0.5);%X axis


xlabel('\bf{X [m]}');
ylabel('\bf{Y [m]}');
zlabel('\bf{Z [m]}');

view([10,10,45])

hold off


