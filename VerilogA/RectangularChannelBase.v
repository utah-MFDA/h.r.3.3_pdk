// Sophia Nielsen, sophi.nieslen@utah.edu
`include "nature_fluid_dynamics"

// this module is an example for other rectangualr channel modules
// do not instantiate this module as its own component, instead use the wrapper
// components RectangularChannelDefault and RectangularChannelSmall
module RectangularChannelBase
// Channel cross section (w - width, h - hieght), channel length (l - length)
// units in meters
// fluid viscosity (nu - dynamic viscosity)
# (parameter L,
  parameter W,
  parameter H,
  parameter NU)

// input and output ports of channel
  (input p
    output n)

  real R_hyd = (12*NU*L)/(1 - 0.63*(H/W)) * 1/(H*H*H/W);
  analog Q(p,n) <+ P(p,n)/R_hyd;

endmodule
