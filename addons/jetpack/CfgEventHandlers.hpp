class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_Init_EventHandlers {
    class CAManBase {
		class dg1_jetpack_init_eh {
			init = "if (isPlayer (_this select 0) && typeOf unitBackpack (_this select 0) in dg1_jetpack_Backpacks) then {cutRsc [""DG1_Jetpack_RSC_Counter"",""PLAIN"",-1,false];} else {cutText ["""", ""PLAIN""];};";
		};
	};
};

class Extended_Take_EventHandlers {
    class CAManBase {
        class dg1_jetpack_take_eh {
            take = "if (isPlayer (_this select 0) && typeOf unitBackpack (_this select 0) in dg1_jetpack_Backpacks) then {cutRsc [""DG1_Jetpack_RSC_Counter"",""PLAIN"",-1,false];} else {cutText ["""", ""PLAIN""];};";
        };
    };
};

class Extended_Put_EventHandlers {
    class CAManBase {
        class dg1_jetpack_put_eh {
            put = "if (isPlayer (_this select 0) && typeOf unitBackpack (_this select 0) in dg1_jetpack_Backpacks) then {cutRsc [""DG1_Jetpack_RSC_Counter"",""PLAIN"",-1,false];} else {cutText ["""", ""PLAIN""];};";
        };
    };
};