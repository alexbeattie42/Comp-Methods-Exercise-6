function mbs = add_point_force(mbs, name, body_name, g)
assert(isnumeric(g) && isvector(g) && length(g) == 2)
% Get bodies ids
b_id = get_body_id(mbs, body_name);
point_force = struct('name', name, 'body', b_id, 'force', g);
mbs.forces.point_force = [mbs.forces.point_force, point_force];