#include "script_component.hpp"
if (GVAR(Thrust)) then {
	if (!(GVAR(Fuel_Recharge)) && GVAR(Fuel_Action) isEqualType 1) then {
		[player,GVAR(Fuel_Action)] call BIS_fnc_holdActionRemove;
	};
	player spawn {
		private _xMove = 0;
		private _yMove = 0;
		private _x = 0;
		private _y = 0;
		private _z = 2;
		private _height = (getPosVisual _this) select 2;
		private _z = _z * ((100 - _height)/100);
		private _velMax = 1.8/(_x + _y + _z);
		private _vel = [0,0,0];
		while {alive _this && GVAR(Thrust) && !(_this getVariable ["ACE_isUnconscious", false]) && typeOf unitBackpack player in GVAR(Backpacks)} do {
			if ((GVAR(Fuel) > 0 || !GVAR(Fuel_Enable))) then {
				_xMove = 0;
				_yMove = 0;
				_x = 0;
				_y = 0;
				_z = 2;
				_height = (getPosVisual _this) select 2;
				_z = _z * ((100 - _height)/100);
				if (inputAction "MoveForward" > 0) then {_yMove = _yMove + 1};
				if (inputAction "MoveBack" > 0) then {_yMove = _yMove - 1};
				if (inputAction "TurnLeft" > 0) then {_xMove = _xMove - 1};
				if (inputAction "TurnRight" > 0) then {_xMove = _xMove + 1};
				if !(_xMove == 0) then {_x = 0.1 + ((_height)/100)};
				if !(_yMove == 0) then {_y = 0.1 + ((_height)/100)};
				_velMax = 1.8/(_x + _y + _z);
				_vel = [0,0,0];
				if ((velocityModelSpace _this) isEqualTo [0,0,0]) then {
					_vel = [_x * _velMax * _xMove,1,_z * _velMax * ((100 - (if (_height > 100) then {100} else {_height}))/100)];
				} else {
					_vel = [_x * _velMax * _xMove,_y * _velMax * _yMove,_z * _velMax * ((100 - (if (_height > 100) then {100} else {_height}))/100)];
				};
				_this setVelocityModelSpace ((velocityModelSpace _this) vectorAdd _vel);
				if (GVAR(Fuel_Enable)) then {
					if (GVAR(Fuel) > 0.1) then {
						GVAR(Fuel) = GVAR(Fuel) - 0.1;
					} else {
						GVAR(Fuel) = 0;
					};
				};
				cutRsc ["DG1_Jetpack_RSC_Counter","PLAIN",-1,false];
			};
			uiSleep  0.1;
		};
		if (GVAR(Fuel_Recharge)) then {
			[] spawn {call FUNC(refuelPack);};
		} else {
			call FUNC(fuelStation);
		};
	};
};