%% Common Parameters
 IOP = [6.7451660984e-2,-1.1709829919e-1,8.1671200690];
dist = [-2.9350008918e-4, 9.2190322166e-6,-2.2562559450e-7,6.1878890685e-5,-7.2907688047e-5,0];

XA = [-0.044038221723;0.89829592555;1.8428648416;2.7928032424;3.731135328;-0.036927916146;0.90108606018;1.8511589932;2.8010339963;3.7422959221;-0.037704361429;0.90892725171;1.8588605461;2.8062554595;3.7520655984;-0.024722332105;0.91454137562;1.8596674595;2.8078118825;3.7544680979;0;0.9263914178;1.8642980884;2.8111736654;3.7628755375];	
YA = [3.751130948;3.7594793917;3.7736433303;3.7823238561;3.7801397656;2.8057675589;2.8180218203;2.8257925207;2.8332144474;2.8378518827;1.8634346772;1.8678901457;1.8758730363;1.8838128654;1.8922797004;0.91840024749;0.92066047041;0.92760553219;0.93553829291;0.94557055946;0;-0.00026178267339;-0.0021390199929;-0.0019752230297;0];	
ZA = [0.072640804133;0.048121990404;0;-0.047649472361;-0.070838477818;0.054102199693;0.026008316122;0.0059282538012;-0.023295585379;-0.044574905144;0.016369939657;0.010208246675;0.0071618170061;-0.0096698096332;-0.020910207448;-0.0091692255168;0.003877584251;0.003049069041;-0.0030509411619;-0.0098127723745;0;0.017342094476;0.016047411487;0.006582607018;0];

%% Image 1 

EOP = [1.60,3.20,3.5,0,0,0];
xa = [-5.3877;-2.92187;-0.49439;1.79834;3.93369;-5.04787;-2.77407;-0.55643;1.5572;3.55246;-4.71235;-2.63868;-0.61275;1.34004;3.19895;-4.43154;-2.5313;-0.66436;1.1514;2.88537;-4.19557;-2.4407;-0.70131;0.99217;2.62277];
ya = [4.93742;4.84433;4.68172;4.49867;4.29866;2.42494;2.3434;2.23887;2.1432;2.04441;0.30738;0.24322;0.17794;0.13305;0.09228;-1.49013;-1.53833;-1.5756;-1.59753;-1.59671;-3.02777;-3.06606;-3.09871;-3.09563;-3.07743];
[EOP,e,sigma_hat,iter] = LSA(xa,ya,XA,YA,ZA,IOP,dist,EOP);
% function [EOP,e,sigma_hat,iter] = LSA(xa,ya,XA,YA,ZA,IOP,dist,EOP)
