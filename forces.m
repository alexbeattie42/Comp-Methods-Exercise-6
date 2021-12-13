function F = forces(mbs, q, t)
if nargin < 3
    t = 0;
end
x = 0:0.01:pi/2;
F = zeros(mbs.nq, 1);
f_idx = 0;
% forces due to gravity
if ~isempty(mbs.gravity)
    q_idx = 0;
    for b = mbs.bodies
       F(q_idx + (1:2)) = b.m .* mbs.gravity;
       q_idx = q_idx + 3;
    end
end

for f = mbs.forces.point_force
   q_idx = f.body;
   force = flip(f.force');
   F(q_idx + (1:2)) = F(q_idx + (1:2)) + force;
end 

for f = mbs.forces.scaled_force
   q_idx = f.body;
   force = flip(f.force');
   force = force * sin(t * 45);
   F(q_idx + (1:2)) = F(q_idx + (1:2)) + force;
end 


for f = mbs.forces.rotational_spring
   b1_idx = f.body1;
   b2_idx = f.body2;
   angle = f.force(1);
   k = f.force(2);
   torque = k * angle;
   force1 = mbs.bodies(f.body1).Ic * torque;
   force2 = mbs.bodies(f.body2).Ic * -torque;
   F(b1_idx + (1:2)) = F(b1_idx + (1:2)) + force1;
   F(b2_idx + (1:2)) = F(b2_idx + (1:2)) + force2;
end 


end
    
