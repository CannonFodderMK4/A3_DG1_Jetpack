//Variables PreInit
DG1_Jetpack_VAR_Backpacks = [];
publicVariable "DG1_Jetpack_VAR_Backpacks";
DG1_Jetpack_VAR_Brake_Text = "";
publicVariable "DG1_Jetpack_VAR_Brake_Text";
DG1_Jetpack_VAR_Brake = false;
publicVariable "DG1_Jetpack_VAR_Brake";
DG1_Jetpack_VAR_Fuel_Action = true;
publicVariable "DG1_Jetpack_VAR_Fuel_Action";
DG1_Jetpack_VAR_Fuel_Cooldown = 5;
publicVariable "DG1_Jetpack_VAR_Fuel_Cooldown";
DG1_Jetpack_VAR_Fuel_Enable = true;
publicVariable "DG1_Jetpack_VAR_Fuel_Enable";
DG1_Jetpack_VAR_Fuel_Max = 100;
publicVariable "DG1_Jetpack_VAR_Fuel_Max";
DG1_Jetpack_VAR_Fuel_Recharge = true;
publicVariable "DG1_Jetpack_VAR_Fuel_Recharge";
DG1_Jetpack_VAR_Fuel_Stations = [];
publicVariable "DG1_Jetpack_VAR_Fuel_Stations";
DG1_Jetpack_VAR_Fuel_Objects = [];
publicVariable "DG1_Jetpack_VAR_Fuel_Objects";
DG1_Jetpack_VAR_Fuel = DG1_Jetpack_VAR_Fuel_Max;
publicVariable "DG1_Jetpack_VAR_Fuel";
DG1_Jetpack_VAR_Refuel = false;
publicVariable "DG1_Jetpack_VAR_Refuel";
DG1_Jetpack_VAR_Thrust = false;
publicVariable "DG1_Jetpack_VAR_Thrust";

//Settings
["DG1_Jetpack_List", "EDITBOX", ["Jetpack Class Names","No quotes, split by comma"], ["Degenerates Extras","Jetpacks"], "", true, { params ["_value"]; _array = _value splitString ", "; DG1_Jetpack_VAR_Backpacks = _array; publicVariable "DG1_Jetpack_VAR_Backpacks";} ] call CBA_fnc_addSetting;
["DG1_Jetpack_Fuel_Enable", "CHECKBOX", "Uses Fuel", ["Degenerates Extras","Jetpacks"], true, true, { params ["_value"]; DG1_Jetpack_VAR_Fuel_Enable = _value;} ] call CBA_fnc_addSetting;
["DG1_Jetpack_Fuel_Max", "SLIDER", ["Tank Size","Flight time in Seconds"], ["Degenerates Extras","Jetpacks"], [10,1000,100,0], true, { params ["_value" ]; DG1_Jetpack_VAR_Fuel_Max = _value;} ] call CBA_fnc_addSetting;
["DG1_Jetpack_Fuel_Recharge", "CHECKBOX", "Recharges when not in use", ["Degenerates Extras","Jetpacks"], true, true, { params ["_value"]; DG1_Jetpack_VAR_Fuel_Recharge = _value;} ] call CBA_fnc_addSetting;
["DG1_Jetpack_Fuel_Cooldown", "SLIDER", ["Recharge Cooldown","Delay before recharge in Seconds"], ["Degenerates Extras","Jetpacks"], [1,60,5,0], true, { params ["_value" ]; DG1_Jetpack_VAR_Fuel_Cooldown = _value;} ] call CBA_fnc_addSetting;
["DG1_Jetpack_Fuel_Stations", "EDITBOX", ["Fuel Station Class Names","No quotes, split by comma"], ["Degenerates Extras","Jetpacks"], "", true, { params ["_value"]; _array = _value splitString ", "; DG1_Jetpack_VAR_Fuel_Stations = _array; publicVariable "DG1_Jetpack_VAR_Fuel_Stations";},true] call CBA_fnc_addSetting;