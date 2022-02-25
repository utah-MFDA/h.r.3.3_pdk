import numpy as np

#define left-hand side of equation
left_side = np.array([[1, 0, 0, 0, 0, -30770.4, 0, 0, 0, 0],
[0, 1, 0, 0, 0, 0, -3840.1, 0, 0, 0],
[0, 0, 1, 0, 0, 0, 0, -4201600.56, 0, 0],
[0, 0, 0, 1, 0, 0, 0, 0, -31244.21, 0],
[0, 0, 0, 0, 1, 0, 0, 0, 0, -30770.4],
[1, 0, 0, 1, 1, 0, 0, 0, 0, 0],
[0, 1, 0, 1, 1, 0, 0, 0, 0, 0],
[0, 0, 1, 0, 1, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 1, 1, 0, -1, 0],
[0, 0, 0, 0, 0, 0, 0, 1, 1, -1]])

#define right-hand side of equation
right_side = np.array([0, 0, 0, 0, 0, 34450, 34450, 34450, 0, 0])

#solve for x and y
np.linalg.inv(left_side).dot(right_side)
