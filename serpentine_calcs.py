import math

def calc_resistence():
    footprint_width = 0.001064 # preset for  5 BENDS
    nu = 0.0010016 # water at 20 deg C, [Pa s], [N s/m2]

    microns_per_pixel = 7.6
    microns_per_layer = 10
    meters_per_micron = 0.000001

    channel_spacing_pixels = 14

    # for cross section 1
    width_pixels = 14;
    hieght_layers = 8;

    channel_spacing = channel_spacing_pixels*microns_per_pixel*meters_per_micron;

    W = width_pixels*microns_per_pixel*meters_per_micron;
    H = hieght_layers*microns_per_layer*meters_per_micron;

    bends = footprint_width/(W+channel_spacing);

    effective_footprint_width = bends*(W+channel_spacing);

    L = bends*effective_footprint_width + effective_footprint_width;

    R_hyd = (12*nu*L)/(1 - 0.63*(H/W)) * 1/(H*H*H/W);

    print(R_hyd)

def footprint_from_resistence():
    R_hyd = 26893665.72900001

    nu = 0.0010016 # water at 20 deg C, [Pa s], [N s/m2]

    microns_per_pixel = 7.6
    microns_per_layer = 10
    meters_per_micron = 0.000001

    channel_spacing_pixels = 14

    # for cross section 1
    width_pixels = 14;
    hieght_layers = 8;

    channel_spacing = channel_spacing_pixels*microns_per_pixel*meters_per_micron;

    W = width_pixels*microns_per_pixel*meters_per_micron;
    H = hieght_layers*microns_per_layer*meters_per_micron;

    L = R_hyd * (math.pow(H,3)/W) * (1 - 0.63*(H/W))/(12*nu)

    L = math.pow(footprint_width,2)/(W+channel_spacing) + footprint_width;

    print(footprint_width)

#footprint_from_resistence()
calc_resistence()
