include <BOSL2/std.scad>
include <ports.scad>
include <openmfda/components/resistor.scad>

module block_resistor(flow_in, flow_out, port_config,
                   blocks = 1,
                   major_channel = [14, 10],
                   minor_channel = [6,5],
                   channel_length=5, eps=1e-2)
{
    // Parameter checks
    assert(is_flow_port(flow_in));
    assert(is_flow_port(flow_out));
    assert(is_struct(port_config));

    // Constants and configuration
    width = struct_val(port_config, "width");
    size = struct_val(port_config, "flow_cross_section");
    sharpness = 10;
    dimensions = resistor_dimensions(blocks, major_channel, minor_channel, channel_length, eps);
    center_offset = dimensions * diagonal([1,1,0]/2);
    center = width/2 * [1,1,1];
    debug = struct_val(port_config, "debug");

    // calculate ports and minimize the angle between exterior and component ports.
    component_ports = resistor_ports(blocks, major_channel, minor_channel, channel_length, eps);
    component_in = component_ports[0];
        // Configuration
    component_out = component_ports[1];

    exterior_ports = [
        fluid_line_input_target(flow_in, port_config),
        fluid_line_output_target(flow_out, port_config)
    ];
    exterior_in = exterior_ports[0];
    exterior_out = exterior_ports[1];

// Parameter checking

    angle = minimize_angle(exterior_ports, component_ports, port_config);

    // geometry
    module fluid_line(exterior_port, component_port) {
        exterior = port_tangent_scale(sharpness, exterior_port);
        component = port_tangent_scale(sharpness,
                    port_translate(center,
                        port_rotate_xy(angle, component_port)));
        path(size, component, exterior, debug=debug);
    }

    %cube(width);

    translate(center)
    rotate([0, 0, angle])
    translate(-center_offset)
    resistor(blocks, major_channel, minor_channel, channel_length, eps);


    color("purple") {
        fluid_line(exterior_in, component_in);
        fluid_line_input_junction(flow_in, port_config);
    }

    color("blue") {
        fluid_line(exterior_out, component_out);
        fluid_line_output_junction(flow_out, port_config);
    }
}
