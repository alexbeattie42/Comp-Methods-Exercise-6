function mbs = add_scaled_force(mbs, name, body_name, g)
assert(isnumeric(g) && isvector(g) && length(g) == 2)
% Get bodies ids
b_id = get_body_id(mbs, body_name);
scaled_force = struct('name', name, 'body', b_id, 'force', g);
mbs.forces.scaled_force = [mbs.forces.scaled_force, scaled_force];