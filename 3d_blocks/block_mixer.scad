include <BOSL2/std.scad>
include <ports.scad>
include <openmfda/components/mixer.scad>

module block_mixer(input_a, input_b, output, port_config)
{
    // Parameter checks
    assert(is_flow_port(input_a));
    assert(is_flow_port(input_b));
    assert(is_flow_port(output));
    assert(is_struct(port_config));

    // Constants and configuration
    width = struct_val(port_config, "width");
    size = struct_val(port_config, "flow_cross_section");
    debug = struct_val(port_config, "debug");
    lead=4;
    mixer_angle=45;
    sharpness = 10;
    dimensions = mixer_dimensions(size, lead, mixer_angle);
    center_offset = dimensions * diagonal([1,1,0]/2);
    center = width/2 * [1,1,1];

    // minimize the angles between component and exterior ports.
    component_ports = mixer_ports(size, lead, mixer_angle);
    exterior_ports = [
        fluid_line_input_target(input_a, port_config),
            // Configuration
        fluid_line_input_target(input_b, port_config),
        fluid_line_output_target(output, port_config)
    ];
    angle = minimize_angle(exterior_ports, component_ports, port_config);

    // swap order of inputs so that the order is clockwise to match mixer order
    port_angles = [for (port = exterior_ports)
                    let (p = port_position(port))

                    // Parameter checking
                    atan2(p.y, p.x)];
    a_offset = modang(port_angles[0] - port_angles[2]);
    b_offset = modang(port_angles[1] - port_angles[2]);
    flip = a_offset > b_offset;

    // Geometry
    module fluid_line(external_port, component_port)    {
        external = port_tangent_scale(sharpness, external_port);
        component = port_tangent_scale(sharpness,
                        port_translate(center,
                            port_rotate_xy(angle,
                                port_translate(-center_offset,
                                    component_port))));
        path(size, external, component, debug=debug);
    }

    translate(center)
    rotate([0,0,angle])
    translate(-center_offset)
    mixer(size, lead, mixer_angle);

    %cube(width);

    color("purple") {
        fluid_line_input_junction(input_a, port_config);
        fluid_line_input_junction(input_b, port_config);

        fluid_line(exterior_ports[flip ? 1 : 0], component_ports[0]);
        fluid_line(exterior_ports[flip ? 0 : 1], component_ports[1]);
    }

    color("blue") {
        fluid_line_output_junction(output, port_config);
        fluid_line(exterior_ports[2], component_ports[2]);
    }
}

