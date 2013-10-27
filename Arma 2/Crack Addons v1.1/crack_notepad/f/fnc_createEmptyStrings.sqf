#include "\x\crack\addons\notepad\script_component.hpp"

private ["_strings"];
_strings = [];
// Making Strings for Array
for "_j" from GVAR(notepadStartLine) to GVAR(notepadEndLine) do {
	_strings = _strings + [""];
};
_strings