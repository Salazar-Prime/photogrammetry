function [tableXI,tableYI,tableZI] = results(XI1,YI1,ZI1,XI2,YI2,ZI2,XI3,YI3,ZI3)

    XIbasc = [3.731135328;0.90108606018;1.8511589932;2.8010339963;3.7422959221;0.90892725171;1.8588605461;2.8062554595;3.7520655984;0.91454137562;1.8596674595;2.8078118825;3.7544680979]
    YIbasc = [3.7801397656;2.8180218203;2.8257925207;2.8332144474;2.8378518827;1.8678901457;1.8758730363;1.8838128654;1.8922797004;0.92066047041;0.92760553219;0.93553829291;0.94557055946]
    ZIbasc = [-0.070838477818;0.026008316122;0.0059282538012;-0.023295585379;-0.044574905144;0.010208246675;0.0071618170061;-0.0096698096332;-0.020910207448;0.003877584251;0.003049069041;-0.0030509411619;-0.0098127723745]
    out = [XI1,abs(XI1-XIbasc),YI1,abs(YI1-YIbasc),ZI1,abs(ZI1-ZIbasc)];
    tableXI = array2table(out,'RowNames',["Image 05","Image 07","Image 08","Image 09","Image 10","Image 12","Image 13","Image 14","Image 15","Image 17","Image 18","Image 19","Image 20"] ...
                               ,'VariableNames',["XI","error BASC XI","YI","error BASC YI","ZI","error BASC ZI"]);
    out = [XI2,abs(XI2-XIbasc),YI2,abs(YI2-YIbasc),ZI2,abs(ZI2-ZIbasc)];
    tableYI = array2table(out,'RowNames',["Image 05","Image 07","Image 08","Image 09","Image 10","Image 12","Image 13","Image 14","Image 15","Image 17","Image 18","Image 19","Image 20"] ...
                               ,'VariableNames',["XI","error BASC XI","YI","error BASC YI","ZI","error BASC ZI"]);
    out = [XI3,abs(XI3-XIbasc),YI3,abs(YI3-YIbasc),ZI3,abs(ZI3-ZIbasc)];
    tableZI = array2table(out,'RowNames',["Image 05","Image 07","Image 08","Image 09","Image 10","Image 12","Image 13","Image 14","Image 15","Image 17","Image 18","Image 19","Image 20"] ...
                               ,'VariableNames',["XI","error BASC XI","YI","error BASC YI","ZI","error BASC ZI"]);
end