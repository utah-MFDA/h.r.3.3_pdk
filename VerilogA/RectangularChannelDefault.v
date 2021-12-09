// Sophia Nielsen, sophi.nieslen@utah.edu
`include "nature_fluid_dynamics"

// preset channel cross section
// default channle cross section for reliable printing
// 8 layers tall, 14 pixels wide
// pixel size:  7.6 microns, layer size:  10  microns
module RectangularChannelDefault
// channel length (l - length (m))
// fluid viscosity (nu - dynamic viscosity)
# (parameter L,
  parameter NU)

// input and output ports of channel
// p - input port for pressure and flow, conservative
// n - output port for pressure and flow, conservative
(input p
  output n)

  real width_pixels = 14
  real hieght_layers = 8

  real microns_per_pixel = 7.6
  real microns_per_layer = 10
  real meters_per_micron = .000001

  real W = width_pixels*microns_per_pixel*meters_per_micron
  real H = hieght_layers*microns_per_layer*meters_per_micron

  // Channel cross section (w - width, h - hieght),
  real R_hyd = (12*NU*L)/(1 - 0.63*(H/W)) * 1/(H*H*H/W);
  analog Q(p,n) <+ P(p,n)/R_hyd;

end module
