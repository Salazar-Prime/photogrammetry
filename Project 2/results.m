function [summary,D,hist,e]=results(EOP_i, EOP_f, D, EOP_basc, hist, iter)
    out = [EOP_i;EOP_f;transpose(diag(D).^0.5);abs(EOP_basc - EOP_f)];
%     out = arrayfun(@ (n) sprintf("%0.3e", n),out)
    row=["Initial Approximation"];
    for i=1:iter
        row=[row,sprintf("Iteration %d",i)];
    end
    summary = array2table(out,'VariableNames',["X0","Y0","Z0","Omega (deg)","Phi (deg)","Kappa (deg)"],'RowNames',["Initial Approximation","Final EOP Value","SD for EOPs","Delta EOP from BASC"]);
          D = array2table(D,'VariableNames',["X0","Y0","Z0","Omega (deg)","Phi (deg)","Kappa (deg)"],'RowNames',["X0","Y0","Z0","Omega (deg)","Phi (deg)","Kappa (deg)"]);
       hist = array2table(hist,'VariableNames',["X0","Y0","Z0","Omega (deg)","Phi (deg)","Kappa (deg)"],'RowNames',row);
end
