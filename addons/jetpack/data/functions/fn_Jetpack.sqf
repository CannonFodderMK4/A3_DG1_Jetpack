addMissionEventHandler ["PlayerConnected",
{
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	remoteExec ["DG1_fnc_Jetpack_Client",_owner];
}];