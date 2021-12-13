function [dydt] = acceleration(mbs, y, t)
[rows, ~] = size(y);
q = y(1:rows/2,:);
qd = y((rows/2)+1:end,:);
dydt = zeros(size(y));
M = mass_matrix(mbs);
f = forces(mbs, q, t);
if mbs.nc == 0
    qdd = M \ f;
    
else
    C = constraints(mbs, q, t);
    Cq = constraints_dq(mbs, q);
    Ct = constraints_dt(mbs, t);
    Cp = Cq * qd + Ct;
    g = constraints_g(mbs, q, qd, t);
    alpha = mbs.balpha;
    beta = mbs.bbeta;

    LHS = [M, Cq'; Cq, zeros(mbs.nc)];
    rhs = [f; g - 2 * alpha * Cp - beta^2 * C];
    qddlambda = LHS \ rhs;
    qdd = qddlambda(1:mbs.nq);
end

dydt(1:rows/2,:) = qd;
dydt((rows/2)+1:end,:) = qdd;
