% Author: Varun Aggarwal
% images: 4,5 and 11,12
% visible: 5,7-10,12-15,17-20
clc; clear all;
%% Linear Intersection - Images 4,5
[IOP, dist, EOP_4, xa_4, ya_4] = data(4);
[~,~,EOP_5, xa_5, ya_5] = data(5);
[XI_1,YI_1,ZI_1] = linear_intersection(EOP_4,EOP_5,IOP,dist,xa_4,ya_4,xa_5,ya_5);

%% Linear Intersection - Images 11,12
[IOP, dist, EOP_11, xa_11, ya_11] = data(11);
[~,~,EOP_12, xa_12, ya_12] = data(12);
[XI_2,YI_2,ZI_2] = linear_intersection(EOP_11,EOP_12,IOP,dist,xa_11,ya_11,xa_12,ya_12);

%% multi-ray intersection - Images, 4,5,11,12
[XI_3,YI_3,ZI_3] = multi_intersection(EOP_4,EOP_5,EOP_11,EOP_12,IOP,dist,xa_4,ya_4,xa_5,ya_5,xa_11,ya_11,xa_12,ya_12);

%% results
[table1,table2,table3] = compile_results(XI_1,YI_1,ZI_1,XI_2,YI_2,ZI_2,XI_3,YI_3,ZI_3);
writetable(table1,"table.xls","Sheet",1,'WriteRowNames',true);
writetable(table2,"table.xls","Sheet",2,'WriteRowNames',true);
writetable(table3,"table.xls","Sheet",3,'WriteRowNames',true);