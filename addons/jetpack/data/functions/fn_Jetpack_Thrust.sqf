//Detect Thrust activation and provide lift
_this spawn {
	while {alive _this} do {
		private _xMove = 0;
		private _yMove = 0;
		private _x = 0;
		private _y = 0;
		private _z = 2;
		private _height = (getPosVisual _this) select 2;
		private _z = _z * ((100 - _height)/100);
		waitUntil {DG1_Jetpack_VAR_Thrust && !(player getVariable ["ACE_isUnconscious", false]) && (DG1_Jetpack_VAR_Fuel > 0 || !DG1_Jetpack_VAR_Fuel_Enable)};
		if (inputAction "MoveForward" > 0) then {_yMove = _yMove + 1};
		if (inputAction "MoveBack" > 0) then {_yMove = _yMove - 1};
		if (inputAction "TurnLeft" > 0) then {_xMove = _xMove - 1};
		if (inputAction "TurnRight" > 0) then {_xMove = _xMove + 1};
		if !(_xMove == 0) then {_x = 0.1 + ((_height)/100)};
		if !(_yMove == 0) then {_y = 0.1 + ((_height)/100)};
		private _velMax = 1.8/(_x + _y + _z);
		private _vel = [0,0,0];
		if ((velocityModelSpace _this) isEqualTo [0,0,0]) then {
			_vel = [_x * _velMax * _xMove,1,_z * _velMax * ((100 - (if (_height > 100) then {100} else {_height}))/100)];
		} else {
			_vel = [_x * _velMax * _xMove,_y * _velMax * _yMove,_z * _velMax * ((100 - (if (_height > 100) then {100} else {_height}))/100)];
		};
		_this setVelocityModelSpace ((velocityModelSpace _this) vectorAdd _vel);
		if (DG1_Jetpack_VAR_Fuel_Enable) then {
			if (DG1_Jetpack_VAR_Fuel > 0.1) then {
				DG1_Jetpack_VAR_Fuel = DG1_Jetpack_VAR_Fuel - 0.1;
			} else {
				DG1_Jetpack_VAR_Fuel = 0;
			};
		};
		sleep 0.1;
	};
};

//Detect Airbrake activation and attempt to slow descent
_this spawn {
	while {alive _this} do {
		waitUntil {DG1_Jetpack_VAR_Brake && (DG1_Jetpack_VAR_Fuel > 0 || !DG1_Jetpack_VAR_Fuel_Enable)};
		private _deceleration = (vectorMagnitude (velocityModelSpace _this)) * 0.25;
		private _vel = (vectorNormalized (velocityModelSpace _this)) vectorMultiply _deceleration;
		_this setVelocityModelSpace ((velocityModelSpace _this) vectorDiff _vel);
		if (DG1_Jetpack_VAR_Fuel_Enable) then {
			private _fuelUse = ((_deceleration / 1.8) * 0.1) * (((getPosVisual _this) select 2)/10);
			if (DG1_Jetpack_VAR_Fuel > _fuelUse) then {
				DG1_Jetpack_VAR_Fuel = DG1_Jetpack_VAR_Fuel - _fuelUse;
			} else {
				DG1_Jetpack_VAR_Fuel = 0;
			};
		};
		sleep 0.1;
	};
};