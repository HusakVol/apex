/*
File: fn_eventCargoUnloaded.sqf
Author:

	Quiksilver
	
Last modified:

	28/01/2023 A3 2.12 by Quiksilver
	
Description:

	Server Cargo Unloaded
__________________________________________________*/

params ['_parent','_child',['_isCustom',FALSE]];
if (!isNull _parent) then {
	if (local _parent) then {
		if (_isCustom) then {
			_parent setMass ((getMass _parent) - (getMass _child));
		};
	} else {
		[_parent,objNull] remoteExec ['QS_fnc_eventCargoUnloaded',_parent,FALSE];
	};
};
if (!isNull _child) then {
	if (local _child) then {
		if (isEngineOn _child) then {
			_child engineOn FALSE;
		};
		if (
			(_child isKindOf 'StaticWeapon') ||
			{(_child isKindOf 'Reammobox_F')}
		) then {
			_child allowDamage (_child getVariable ['cargo_isDamageAllowed',TRUE]);
		};
	} else {
		[objNull,_child] remoteExec ['QS_fnc_eventCargoUnloaded',_child,FALSE];
	};
};
if ((typeof _parent) in ['B_T_VTOL_01_vehicle_F', 'B_T_VTOL_01_vehicle_blue_F', 'B_T_VTOL_01_vehicle_olive_F']) then {
    // comment 'Unhide stretchers on stomper on low altitude'
    if ((typeOf _child) in ['B_UGV_01_F', '	B_T_UGV_01_olive_F']) then {
        [_child, 7] spawn (missionNamespace getVariable 'QS_fnc_clientInteractUGV');
    };
};
[_parent,TRUE,TRUE] call QS_fnc_updateCenterOfMass;