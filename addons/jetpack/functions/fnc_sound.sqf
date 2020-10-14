#include "script_component.hpp"
if (GVAR(Sound_Continue) != "") then {
	player spawn {
		if (!GVAR(Sound_Play) && {alive _this && {(GVAR(Thrust) || {GVAR(Brake)}) && {!(_this getVariable ["ACE_isUnconscious", false]) && {typeOf unitBackpack _this in GVAR(Backpacks)}}}}) then {
			GVAR(Sound_Play) = true;
			_soundSource = "#particlesource" createVehicle [0,0,0];
			_soundSource attachTo [_this, [0,0,0], "pelvis"];
			if (!GVAR(Spool_Down) && GVAR(Sound_Start) != "" && {((GVAR(Thrust) && {!(_this getVariable ["ACE_isUnconscious", false])}) || {GVAR(Brake) && {((getPosVisual _this) select 2) > 0.1}}) && {(GVAR(Fuel) > 0 || {!GVAR(Fuel_Enable)}) && {typeOf unitBackpack _this in GVAR(Backpacks)}}}) then {
				_soundSource say3D GVAR(Sound_Start);
				_startTime = time;
				while {(time - _startTime) <= (GVAR(Sound_Start_Length) - 0.1)} do {sleep 0.1};
			};
			if (((GVAR(Thrust) && {!(_this getVariable ["ACE_isUnconscious", false])}) || {GVAR(Brake) && {((getPosVisual _this) select 2) > 0.1}}) && {(GVAR(Fuel) > 0 || {!GVAR(Fuel_Enable)}) && {typeOf unitBackpack _this in GVAR(Backpacks)}}) then {
				_startTime = time;
				_soundSource say3D GVAR(Sound_Continue);
				while {((GVAR(Thrust) && {!(_this getVariable ["ACE_isUnconscious", false])}) || {GVAR(Brake) && {((getPosVisual _this) select 2) > 0.1}}) && {(GVAR(Fuel) > 0 || {!GVAR(Fuel_Enable)}) && {typeOf unitBackpack _this in GVAR(Backpacks)}}} do {
					if ((time - _startTime) >= GVAR(Sound_Continue_Length) - 0.1) then {
						_startTime = time;
						_soundSource say3D GVAR(Sound_Continue);
					};
					sleep 0.1;
				};
			};
			deleteVehicle _soundSource;
			GVAR(Sound_Play) = false;
			if (GVAR(Sound_End) != "") then {
				GVAR(Spool_Down) = true;
				_soundSource = "#particlesource" createVehicle (position _this);
				_soundSource attachTo [_this, [0,0,0], "pelvis"];
				_soundSource say3D GVAR(Sound_End);
				_startTime = time;
				_playSound = true;
				while {(time - _startTime) <= GVAR(Sound_End_Length) && _playSound} do {
					if (GVAR(Thrust) && {!(_this getVariable ["ACE_isUnconscious", false])}) then {
						_playSound = false;
					};
					if (GVAR(Brake) && {((getPosVisual _this) select 2) > 0.1}) then {
						_playSound = false;
					};
					if (!(typeOf unitBackpack _this in GVAR(Backpacks))) then {
						_playSound = false;
					};
					sleep 0.1;
				};
				deleteVehicle _soundSource;
				sleep 0.1;
				GVAR(Spool_Down) = false;
			};
		};
	};
};