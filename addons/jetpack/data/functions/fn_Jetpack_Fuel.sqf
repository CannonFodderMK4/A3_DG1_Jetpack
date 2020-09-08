//Reset Fuel to Max if current value is above
_this spawn {
	while {alive _this} do {
		waitUntil {DG1_Jetpack_VAR_Fuel > DG1_Jetpack_VAR_Fuel_Max};
		DG1_Jetpack_VAR_Fuel = DG1_Jetpack_VAR_Fuel_Max;
		sleep 1;
	};
};

//Refuel Jetpack
_this spawn {
	while {alive _this} do {
		private _recharge = true;
		waitUntil {!DG1_Jetpack_VAR_Thrust && !DG1_Jetpack_VAR_Brake && (DG1_Jetpack_VAR_Fuel < DG1_Jetpack_VAR_Fuel_Max) && (DG1_Jetpack_VAR_Fuel_Recharge || DG1_Jetpack_VAR_Refuel)};
		if (DG1_Jetpack_VAR_Fuel_Recharge) then {
			for [{_i=0},{_i < DG1_Jetpack_VAR_Fuel_Cooldown}, {_i = _i + 0.1}] do {
				if (DG1_Jetpack_VAR_Thrust && DG1_Jetpack_VAR_Brake) exitWith {_recharge = false};
				sleep 0.1;
			};
		};
		if (_recharge) then {
			while {!DG1_Jetpack_VAR_Thrust && !DG1_Jetpack_VAR_Brake && (DG1_Jetpack_VAR_Fuel < DG1_Jetpack_VAR_Fuel_Max)} do {
				DG1_Jetpack_VAR_Fuel = DG1_Jetpack_VAR_Fuel + 1;
				if (DG1_Jetpack_VAR_Fuel > DG1_Jetpack_VAR_Fuel_Max) then {DG1_Jetpack_VAR_Fuel = DG1_Jetpack_VAR_Fuel_Max;};
				sleep 0.1;
			};
		};
		sleep 0.1;
	};
};

//Setup Refueling Stations
if (count DG1_Jetpack_VAR_Fuel_Stations > 0) then {
	{
		if (typeOf _x in DG1_Jetpack_VAR_Fuel_Stations) then {
			DG1_Jetpack_VAR_Fuel_Objects pushBackUnique _x;
		}
	} forEach (allMissionObjects "All");
	publicVariable "DG1_Jetpack_VAR_Fuel_Objects";
};
if (count DG1_Jetpack_VAR_Fuel_Objects > 0) then {
	{
		_x spawn {
			while {alive player} do {
				waitUntil {!thrust && !emergencyBrake && (DG1_Jetpack_VAR_Fuel < DG1_Jetpack_VAR_Fuel_Max) && !DG1_Jetpack_VAR_Fuel_Recharge && DG1_Jetpack_VAR_Fuel_Action};
				private _refuelTime = (DG1_Jetpack_VAR_Fuel_Max - DG1_Jetpack_VAR_Fuel)/10;
				private _refuelAction = [
					_this,
					"Refuel",
					"",
					"",
					"_this distance _target < 3",
					"_caller distance _target < 3",
					{
						hint "Refueling Jetpack";
						DG1_Jetpack_VAR_Refuel = true;
					},
					{},
					{
						hint "Refueling Complete";
						DG1_Jetpack_VAR_Refuel = false;
						DG1_Jetpack_VAR_Fuel_Action = true;
						DG1_Jetpack_VAR_Fuel = DG1_Jetpack_VAR_Fuel_Max;
					},
					{
						hint "Refueling interrupted";
						DG1_Jetpack_VAR_Refuel = false;
						DG1_Jetpack_VAR_Fuel_Action = true;
						[(_this select 0),(_this select 2)] call BIS_fnc_holdActionRemove;
					},
					[],
					_refuelTime,
					0,
					true,
					false,
					true
				] call BIS_fnc_holdActionAdd;
				DG1_Jetpack_VAR_Fuel_Action = false;
				waitUntil {thrust || DG1_Jetpack_VAR_Fuel_Action};
				if (thrust && !DG1_Jetpack_VAR_Fuel_Action) then {
					[_this,DG1_Jetpack_VAR_Fuel_Action] call BIS_fnc_holdActionRemove;
					DG1_Jetpack_VAR_Fuel_Action = true;
				};
				sleep 1;
			};
		};
	} forEach DG1_Jetpack_VAR_Fuel_Objects;
};

//Run Onscreen Overlay
_this spawn {
	while {alive _this} do {
		if (typeOf unitBackpack _this in DG1_Jetpack_VAR_Backpacks) then {cutRsc ["DG1_Jetpack_RSC_Counter","PLAIN",-1,false];} else {cutText ["", "PLAIN"];};
	};
	cutText ["", "PLAIN"];
};