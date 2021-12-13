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

U = zeros(N_t+1, length(U_0));
V = zeros(N_t+1, length(V_0));
u = U_0(:);
v = V_0(:);
% U(1, :) = u';
% V(1, :) = v';

[row, ~] = size(u);

init = cat(1,u,v);
[t, out] = ode45(accfun, tspan,init, odeset('AbsTol',1e-8,'Stats','on' ));
U = out(:,1:row);
V = out(:,row + 1:end);
% U = q(end,1);
% V = q(end,2);
% Step equations forward in time
% for n = 1:N_t
%     init = cat(1,u,v);
%     [dxdy] = accfun(tspan(n),init);
%     u = dxdy(1:row,:);
%     v = dxdy(row + 1:end,:);
% %     v = v + dt*qdd;
% %     u = u + dt*v;
%     U(n + 1, :) = u';
%     V(n + 1, :) = v';
% end
% t = tspan;
end

