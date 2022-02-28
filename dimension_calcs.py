import math

def straight_channel_resistence(L, nu):
    microns_per_pixel = 7.6
    microns_per_layer = 10
    meters_per_micron = 0.000001

    # for cross section 1
    width_pixels = 14;
    hieght_layers = 8;

    W = width_pixels*microns_per_pixel*meters_per_micron;
    H = hieght_layers*microns_per_layer*meters_per_micron;

    R_hyd = (12*nu*L)/(1 - 0.63*(H/W)) * 1/(H*H*H/W);

    print(R_hyd)
    return R_hyd

def serpentine_channel_resistence(footprint_width, nu):

    microns_per_pixel = 7.6
    microns_per_layer = 10
    meters_per_micron = 0.000001

    channel_spacing_pixels = 14

    # for cross section 1
    width_pixels = 14;
    hieght_layers = 8;

    channel_spacing = channel_spacing_pixels*microns_per_pixel*meters_per_micron

    W = width_pixels*microns_per_pixel*meters_per_micron
    H = hieght_layers*microns_per_layer*meters_per_micron

    bends = footprint_width/(W+channel_spacing)

    effective_footprint_width = bends*(W+channel_spacing)

    L = bends*effective_footprint_width + effective_footprint_width

    R_hyd = (12*nu*L)/(1 - 0.63*(H/W)) * 1/(H*H*H/W)

    print(R_hyd)

def length_from_resistence(R_hyd, nu, width_pixels, hieght_layers):
    microns_per_pixel = 7.6
    microns_per_layer = 10
    meters_per_micron = 0.000001

    channel_spacing_pixels = 14

    W = width_pixels*microns_per_pixel*meters_per_micron;
    H = hieght_layers*microns_per_layer*meters_per_micron;

    L = R_hyd * (math.pow(H,3)/W) * (1 - 0.63*(H/W))/(12*nu)

    return(L)

def footprint_from_resistence(R_hyd, nu, width_pixels, hieght_layers):

    microns_per_pixel = 7.6
    microns_per_layer = 10
    meters_per_micron = 0.000001

    L = length_from_resistence(R_hyd, nu, width_pixels, hieght_layers)

    W = width_pixels*microns_per_pixel*meters_per_micron;
    H = hieght_layers*microns_per_layer*meters_per_micron;

    channel_spacing_pixels = 14
    channel_spacing = channel_spacing_pixels*microns_per_pixel*meters_per_micron

    footprint_width = 0.5*(math.sqrt(channel_spacing+W)*math.sqrt(channel_spacing+4*L+W) - channel_spacing - W)
    bends =  footprint_width/(W + channel_spacing)

    bends = round(bends)

    effective_footprint_width = bends*(W+channel_spacing)

    print(effective_footprint_width)
    print(bends)
    return(effective_footprint_width)

def flow_rate(R_hyd, del_P):
    flow_rate = del_P/R_hyd
    print(flow_rate)
    return flow_rate

serpentine_channel_resistence(0.001064, 0.0010016)
straight_channel_resistence(0.0001, 0.0010016)
straight_channel_resistence(0.00071, 0.0010016)
