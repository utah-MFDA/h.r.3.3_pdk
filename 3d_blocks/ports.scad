include <flow.scad>

// width = struct_val(port_config, "width");
// port_io_offset = struct_val(port_config, "io_offset");
// port_collision_offset = struct_val(port_config, "collision_offset");
// port_flow_cross_section = struct_val(port_config, "flow_cross_section");
// port_control_cross_section = struct_val(port_config, "control_cross_section");
// port_top_spacing = struct_val(port_config, "top_spacing");
// port_side_spacing = struct_val(port_config, "side_spacing");
// debug = struct_val(port_config, "debug");
// debug_center = struct_val(port_config, "debug_center");

function create_port_config(
    width = 80,
    io_offset = 3,
    collision_offset = [3, 5],
    flow_cross_section = [4,8],
    control_cross_section = [6,8],
    top_spacing = [3/16, 3/8],
    side_spacing = [1/4, 1/4],
    debug = false,
    debug_center=true) = struct_set([], [
    "width", width,
    "io_offset", io_offset,
    "collision_offset", collision_offset,
    "flow_cross_section", flow_cross_section,
    "control_cross_section", control_cross_section,
    "top_spacing", top_spacing,
    "side_spacing", side_spacing,
    "debug", debug,
    "debug_center", debug_center
]);

function diagonal(v) = [
    for (i=[0:len(v)-1])
        [for (j=[0:len(v)-1])
             i == j ? v[i] : 0]];

function port_position(target) = target[0];
function port_tangent(target) = target[1];
function port_normal(target) = target[2];
function port_tangent_scale(scalar, target) = [target[0], scalar*target[1], target[2]];

function port_translate(center, target) = [center, [0,0,0], [0,0,0]] + target;
function vecrotate_xy(a) = [
                        [cos(a), sin(a), 0],
                        [-sin(a), cos(a), 0],
                        [0, 0, 1]];
function port_rotate_xy(angle_xy, target) =
    let (transform = vecrotate_xy(angle_xy))
    [for (t = target) t*transform];

module check_flow_port(port) {
    assert(len(port) == 3, "incorrect flow port components");
    assert(abs(port.x) <= 1, "flow port vector x component greater than 1");
    assert(abs(port.y) <= 1, "flow port vector y component greater than 1");
    assert(abs(port.z) <= 1, "flow port vector z component greater than 1");
    assert(port != [0, 0, 0], "invalid center flow port") ;
}

// I can't get these to work as functions
function assert_flow_port(port) =
    assert(len(port) == 3, "incorrect flow port components")
    assert(abs(port.x) <= 1, "flow port vector x component greater than 1")
    assert(abs(port.y) <= 1, "flow port vector y component greater than 1")
    assert(abs(port.z) <= 1, "flow port vector z component greater than 1")
    assert(port != [0, 0, 0], "invalid center flow port")
    true;

function is_flow_port(port) =
    len(port) == 3 && port != [0, 0, 0]
        && abs(port.x) <= 1 && abs(port.y) <= 1 && abs(port.z) <= 1;

module check_control_port(port) {
    assert(len(port) == 2, "control port struct must have two components");
    face = port[0];
    offset = port[1];
    assert(len(face) == 3, "face vector must have three components");
    assert(norm(face) == 1, "control port must be on face");
    assert(len(offset) == 2, "face offset must have two components");
    assert(abs(offset.x) == 1, "face x offset must be 1");
    assert(abs(offset.y) == 1, "face y offset must be 1");
}

// I can't get these to work as functions
function assert_control_port(port) =
    assert(len(port) == 2, "control port struct must have two components")
    let (face = port[0], offset = port[1])
    assert(len(face) == 3, "face vector must have three components")
    assert(norm(face) == 1, "control port must be on face")
    assert(len(offset) == 2, "face offset must have two components")
    assert(abs(offset.x) == 1, "face x offset must be 1")
    assert(abs(offset.y) == 1, "face y offset must be 1")
    true;

function is_control_port(port) =
    len(port) == 2 &&
    len(port[0]) == 3 &&
    norm(port[0]) == 1 &&
    len(port[1]) == 2 &&
    abs(port[1].x) == 1 &&
    abs(port[1].y) == 1;

// This geometry provides a bridging junction over the crossings to guarantee
// clearance. Each cell should instantiate a junction for each connection.
// fluid_line_target function will return the connection geometry relative to the
// junction.
module control_line_junction(face, offset, port_config) {
    debug = struct_val(port_config, "debug");
    size = struct_val(port_config, "control_cross_section");

    a = control_line_target(face, offset, port_config);
    b = control_line_target_raw(face, offset, port_config);
    path(size, [a[0], -a[1], a[2]],
               [b[0], b[1], b[2]], steps = 2, debug=debug);
}

module fluid_line_input_junction(port, port_config) {
    fluid_line_junction(port, 1, port_config);
}

module fluid_line_output_junction(port, port_config) {
    fluid_line_junction(port, -1, port_config);
}
module fluid_line_junction(port, io, port_config) {
    debug = struct_val(port_config, "debug");
    size = struct_val(port_config, "flow_cross_section");
    a = fluid_line_target(port, io, port_config);
    b = fluid_line_target_raw(port, io, port_config);
    path(size, port_tangent_scale(-1, a), b, debug=debug);
}

function fluid_line_input_target(port, port_config, clearance=2) =
    fluid_line_target(port, 1, port_config, clearance);

function fluid_line_output_target(port, port_config, clearance=2) =
    fluid_line_target(port, -1, port_config, clearance);

// This is the point that defines the junction connection point where cells should attach lines.
function fluid_line_target(port, io, port_config, clearance=2) =
    let (size = struct_val(port_config, "flow_cross_section"))
    let (width = struct_val(port_config, "width"))
    let (io_offset = io*struct_val(port_config, "io_offset"))
    let (collision_offset = struct_val(port_config, "collision_offset"))
    let (target = fluid_line_target_raw(port, io, port_config, clearance=clearance))
    let (offset = norm(port) == 1 || (norm(port) < 1.5 && port.z != 0) ? clearance * target[1] :
                    norm(port) < 1.5 ? (size.x/2 + abs(io_offset)) * target[1] :
                       (size.x/2 + 2*abs(io_offset) + collision_offset.x) * target[1])
    [target[0] + offset, target[1], target[2]];

// This is the point where fluid lines from different cells meet.
function fluid_line_target_raw(port, io, port_config, clearance=2) =
    assert(!is_undef(port))
    let (width = struct_val(port_config, "width"))
    let (io_offset = io*struct_val(port_config, "io_offset"))
    let (collision_offset = struct_val(port_config, "collision_offset"))
    let (center = width/2 * [1,1,1])
    let (is_top = (norm(port) == 1 && (port.z != 0)))
    let (base = width/2 * port)
    let (angle = atan2(port.y, port.x))
    let (offset = (-io_offset + 2*collision_offset.x*port.z))
    let (side = [offset*cos(90 + angle),
                 offset*sin(90 + angle),
                 collision_offset.y*port.x*port.y])
    let (top = [0, io_offset*port.z, 0])
    let (target_offset = is_top ? top : side)
    let (target = center + base + target_offset)
    let (target_normal = is_top ? [0, 0, -port.z] : [-cos(angle), -sin(angle), 0])
    let (last_sweep_normal = is_top ? [-1, 0, 0] : [0, 0, 1])
    [target, target_normal, last_sweep_normal];

function control_line_target(face, offset, port_config) =
    let (on_face = control_line_target_raw(face, offset, port_config))
    port_translate(2*port_tangent(on_face), on_face);

function control_line_target_raw(face, offset, port_config) =
    let (width = struct_val(port_config, "width"))
    let (top_spacing = struct_val(port_config, "top_spacing"))
    let (side_spacing = struct_val(port_config, "side_spacing"))
    let (spacing = width * (face.z != 0 ? top_spacing : side_spacing))
    // positive or negative based sign of one-hot.
    let (dir = face.x + face.y + face.z)
    // place on face.
    let (updown = (dir+1)*width/2)
    // orthogonal bezier anchor
    let (normal = -face)
    // position on the face)
    let (face_center = width/2 * [1, 1])
    let (face_offset = offset * diagonal([dir, 1]))
    let (spot = face_center + spacing * diagonal(face_offset))
    let (target = face.z != 0 ? [spot.x, spot.y, updown] :
                         face.x != 0 ? [updown, spot.x, spot.y] :
                                [spot.x, updown, spot.y])
    let (last_normal = face.z != 0 ? [0, -face.z*offset.y, 0] :
                          face.x != 0 ? [0, 0, 1] :
                                        [0, 0, 1])
    [target + normal, normal, last_normal];

module port_demonstrator(port_config)
{
    width = struct_val(port_config, "width");

    %cube(width);
    for (i = [-1:1], j = [-1:1], k = [-1:1], m = [-1,1]) {
        p = [i, j, k];
        if (p != [0,0,0]) {
            color( m == 1 ? "purple" : "blue")
            fluid_line_junction(p, m, port_config);
        }
    }
    for (i = [-1,1], j = [[0,0,i], [0,i,0], [i,0,0]], m = [-1,1], n = [-1,1]) {
        color("orange")
        control_line_junction(j, [m,n], port_config);
    }
}


// Least squares regression on a single variable is the arithmetic mean
// This minimizes the angle alignment between the component and exterior ports.
function posang(a) = (modang(a) + 360) % 360;
function minimize_angle(ports, anchors, port_config) =
    // BOSL2 likes to use +-180, but stripping the sign to only positive removes
    // problems when crossing the boundary
    let (width = struct_val(port_config, "width"))
    let (center = width/2 * [1,1,1])
    let (port_angles = [for (port = ports)
                            let (a = port_position(port) - center)
                            posang(atan2(a.y, a.x))])
    let (anchor_angles = [for (anchor = anchors)
                            let (a = port_position(anchor))
                            posang(atan2(a.y, a.x))])
    let (diff = port_angles - anchor_angles)
    let (positive = [for (i = diff) posang(i)])
    modang(sum(positive)/len(positive));

