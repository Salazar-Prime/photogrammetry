function [omega,phi,kappa] = calc_opk(S)

[V,D] = eig(S);
[~,id] = sort(diag(D),'descend');
ev = V(:,id(1));
% quat2rotm(ev')
r13 = 2*ev(2)*ev(4) + 2*ev(1)*ev(3);
r12 = 2*ev(2)*ev(3) - 2*ev(1)*ev(4);
r11 = ev(2)^2 + ev(1)^2 - ev(3)^2 - ev(4)^2;
r23 = 2*ev(3)*ev(4) - 2*ev(1)*ev(2);
r33 = ev(4)^2 + ev(1)^2 - ev(3)^2 - ev(2)^2;

phi = asin(r13); % r13
kappa = atan2(-r12/cos(phi),r11/cos(phi))
omega = atan2(-r23/cos(phi),r33/cos(phi))
end