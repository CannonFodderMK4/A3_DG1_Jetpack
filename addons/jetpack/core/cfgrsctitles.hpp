class RscTitles
{
	class DG1_Jetpack_RSC_Counter
	{    
		idd = -1;
		fadeIn = 0;
		fadeOut = 0;
		duration = 1000000;
		onLoad = "(\
			(_this select 0) displayCtrl -1) ctrlSetText ('Jetpack Fuel = ' + ((100 * (DG1_Jetpack_VAR_Fuel / DG1_Jetpack_VAR_Fuel_Max)) toFixed 1) + '%\nFlight Time (s) = ' + str (floor DG1_Jetpack_VAR_Fuel) + DG1_Jetpack_VAR_Brake_Text)\
		";
		class controls
		{
			class ExampleControl
			{    
				idc = -1;
				type = 0;
				style = 528;
				lineSpacing = 1;
				x = safeZoneX + 0.05; 
				y = safeZoneY + safeZoneH - 0.6;
				w = 0.6 * 3/4;
				h = 0.3;
				font = "EtelkaNarrowMediumPro";
				sizeEx = 0.05;
				colorBackground[] = {,0,0,0};
				colorText[] = {1,1,1,1};
				text = "Jetpack Fuel = 100%\nFlight Time (s) = 100";
			};  
		};	
	};
};