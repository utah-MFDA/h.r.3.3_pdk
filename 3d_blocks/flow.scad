include <BOSL2/std.scad>

// function diagonal(v) = [[v.x, 0, 0], [0, v.y, 0], [0, 0, v.z]];
// module segment_path(size, start, delta) {
//     assert(len(delta) > 0);
//     offset = -normal*diagonal(size)/2;
//     normal = unit(delta[0]);
//     assert(sum(delta[0]) == norm(delta[0]), "delta must be a orthogonal vector");
//     module inner(size, start, last, delta) {
//         translate(start)
//         cube(delta[0] + d);
//         if (d.z > 0) {

//             cube([size.x, size.y, delta.z + size.z])
//         } else if (d.y > 0) {
//             cube([size.x, size.y, delta + size.z])

//         } else if (d.x > 0) {
//             if ()
//             cube([, size.x, size.y])
//         } else {
//             assert(false, "delta must be non-zero");
//         }
//         if (len(delta) > 1) {
//             end = start + delta[0];
//             inner(size, start, delta[0], slice(delta, 1, -1));;
//         }
//     }
//     inner(size, start, [0,0,0], delta);
// }

// segment_path([1,4,9], [1,1,1], [[0,10,0], [0,0,10], [10, 0, 0]]);
module bend(size, cross) {
    bezier_sweep(square(cross, center=debug_center),
                [[0,0,0], [0, 0, size.y], [0, 0, size.y], [size.x, 0, size.y]]);
}

module path(size, start, end, steps=16, debug=false, debug_center=false) {
    control = [port_position(start),
               port_position(start) + port_tangent(start),
               port_position(end) + port_tangent(end),
               port_position(end)];
    if (debug) debug_bezier(control, N=len(control)-1);
    else bezier_sweep(square(size, center=!debug_center), control, splinesteps=steps,
                      normal=port_normal(start), last_normal=port_normal(end));
}
