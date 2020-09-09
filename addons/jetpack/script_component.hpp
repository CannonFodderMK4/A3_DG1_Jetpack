#define COMPONENT jetpack
#define COMPONENT_BEAUTIFIED JetPack
#include "script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_JETPACK
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_JETPACK
    #define DEBUG_SETTINGS DEBUG_SETTINGS_JETPACK
#endif

#include "script_macros.hpp"