function [t, U, V] = eqn_of_motion(accfun, T, U_0, V_0, dt)
%eqn_of_motion Solves ODE system using ode45
%   accfun - function that returns accelerations of the system
%       accfun(u, v, t)
%   T - final time
%   U_0 - initial coordinates
%   V_0 - initial velocity
%   dt - time step
%   As an output function returns
%   t - time vector from 0 to T
%   u - displacements associated with t
%   v - velocities associated with t
N_t = floor(round(T/dt));
% fprintf('N_t: %d\n', N_t);
tspan = linspace(0, N_t*dt, N_t+1);

u = U_0(:);
v = V_0(:);

[row, ~] = size(u);

init = cat(1,u,v);
[t, out] = ode45(accfun, tspan,init, odeset('AbsTol',1e-8,'Stats','on' ));
U = out(:,1:row);
V = out(:,row + 1:end);
end

