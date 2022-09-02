Rch = 474.5706000000002;

Ra = 30296.58710400001 + Rch;
Rb = 3369.4512600000007 + Rch;

%% resistence values below not verified
Rc = 4201600.56;
Rd = 31244.21;
Re = 30770.4;

Pa = 34450;

%% double serpentine test

Q_s = Pa/(2*(Ra-Rch))
Pb_s = Q_s*(Ra-Rch)

%% Mixer test

A_m = [[Rch, 0, 0, 1];
    [0, Rch, 0, 1];
    [0, 0, Rch, -1];
    [1, 1, -1, 0]];

B_m = [Pa; Pa; 0; 0];

x_m = linsolve(A_m, B_m)
%% Simplified Zones 1 and 2 test
A12 = [[Ra, 0, 0, 1];
       [0, Rb, 0, 1];
       [0, 0, Rch, -1];
       [1, 1, -1, 0]
       ];
   
B12 = [Pa; Pa; 0; 0];

x12 = linsolve(A12, B12)

%% Zones 1 and  2  test complex

% A12 = [[Ra,  0, 0,  1, 0, 0];
%        [0,  Rb, 0,  0, 1, 0];
%        [Rch, 0, 0, -1, 0, 1];
%        [0, Rch, 0, 0, -1, 1];
%        [0, 0, Rch, 0,  0, -1];
%        [1, 1, -1, 0, 0, 0];
%        ];
% 
% B12 = [Pa; Pa; 0; 0; 0; 0];
% 
% x12 = linsolve(A12, B12)

%% Full chip test

A = [[Ra, 0, 0, 0, 0, 1, 0];
    [0, Rb, 0, 0, 0, 1, 0];
    [0, 0, Rc, 0, 0, 0, 1];
    [0, 0, 0, Rd, 0, -1, 1];
    [0, 0, 0, 0, Re, 0, -1];
    [1, 1, 0, -1, 0, 0, 0]
    [0, 0, 1, 1, -1, 0, 0]];

B = [Pa; Pa; Pa; 0; 0; 0; 0];

%linsolve(A, B)

%% percent error

actual = [0.5685, 17225];
simulated = [0.569, 17200];
error = (abs(actual - simulated)./actual).*100