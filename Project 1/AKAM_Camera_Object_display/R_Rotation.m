function [R] = R_Rotation(w,p,k)
% Programmed by Kim, Eui Myoung
% Date : 2003. 8. 19
% Computes R_Rotation Matrix
% Program name : R_Rotation.m
% ------------------------
% [R] = R_Rotation(w,p,k)
% unit : radian
%         r11 r12 r13    1   0    0   | cosp 0 sinp |cosk -sink  0     
% R_wpk = r21 r22 r23  = 0 cosw -sinw |  0   1   0  |sink  cosk  0
%         r31 r32 r33    0 sinw  cosw |-sinp 0 cosp |  0    0    1

sw=sin(w);cw=cos(w);
sp=sin(p);cp=cos(p);
sk=sin(k);ck=cos(k);

R_Rotation_w = [ 1  0    0
                 0  cw -sw   
                 0  sw  cw];
R_Rotation_p = [ cp  0  sp
                 0   1   0   
                -sp  0  cp];
R_Rotation_k = [ ck -sk 0
                 sk  ck 0   
                  0  0  1 ];
R = R_Rotation_w * R_Rotation_p * R_Rotation_k;