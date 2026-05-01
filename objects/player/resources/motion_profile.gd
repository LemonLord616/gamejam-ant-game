extends Resource
class_name MotionProfileResource


## Power is used to calculate Force applied to Actuator: F = P/v, v - current velocity
@export_range(0.0, 10000000.0, 0.1, "Watts kg*px^2/s^3") var power: float = 500000.0
@export_range(0.0, 50000000.0, 0.1, "Watts kg*px^2/s^3") var run_power: float = 1000000.0

## Start Force that is applied to Actuator: F = F_start
@export_range(0.0, 100000.0, 0.1, "Newtons kg*px/s^2") var max_force: float = 20000.0
@export_range(0.0, 500000.0, 0.1, "Newtons kg*px/s^2") var run_max_force: float = 40000.0

## Damping coefficent
@export_range(0.0, 200.0, 0.1) var damp: float = 50.0

## Stop sliding and make velocity zero threshold
## Kind of "decisive" stop
@export_range(0.0, 100.0, 0.01) var decisive_stop_threshold: float = 20.0

## Jump impulse is calculated from stored Energy: J = mv = m√(2E/m) = √(2Em)
@export_range(0.0, 2000.0, 0.1, "Joules") var jump_energy: float = 100.0
