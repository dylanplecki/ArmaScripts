//     ____   ____       _       ____   _  __        _   _    ___    _____   _____   ____       _      ____  
//    / ___| |  _ \     / \     / ___| | |/ /       | \ | |  / _ \  |_   _| | ____| |  _ \     / \    |  _ \ 
//   | |     | |_) |   / _ \   | |     | ' /        |  \| | | | | |   | |   |  _|   | |_) |   / _ \   | | | |
//   | |___  |  _ <   / ___ \  | |___  | . \        | |\  | | |_| |   | |   | |___  |  __/   / ___ \  | |_| |
//    \____| |_| \_\ /_/   \_\  \____| |_|\_\       |_| \_|  \___/    |_|   |_____| |_|     /_/   \_\ |____/ 
//                                                                                                          
//*********************************************************************************************************************
//
// XEH SERVER POST-INITIALIZATION
//
//*********************************************************************************************************************
if (isserver) then {
	
	GVAR(synDataVar) = [-1, objNull, objNull, []]; // [_requestedDataType, _requestedDataCarrier, _sender, _args]
	publicvariable QUOTE(GVAR(synDataVar));
	
	GVAR(ackDataVar) = [-1, objNull, objNull, [], []]; // [_sentDataType, _requestedDataCarrier, _sentDataRequestor, _sentData, _args]
	publicvariable QUOTE(GVAR(ackDataVar));
	
};