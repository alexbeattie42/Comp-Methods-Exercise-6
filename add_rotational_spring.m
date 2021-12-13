function mbs = add_rotational_spring(mbs, name, body_name,body2_name, g)
assert(isnumeric(g) && isvector(g) && length(g) == 2)
% Get bodies ids
b1 = get_body_id(mbs, body_name);
b2 = get_body_id(mbs, body2_name);
rotational_spring = struct('name', name, 'body1', b1, 'body2',b2, 'force', g);
mbs.forces.rotational_spring = [mbs.forces.rotational_spring, rotational_spring];