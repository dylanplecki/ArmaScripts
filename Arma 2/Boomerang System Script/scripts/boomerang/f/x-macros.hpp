// Macros
//----------------------

#define ifDebug(debugLevel) if ((CRACK_sf_debugEnabled select 0) AND ((CRACK_sf_debugEnabled select 1) >= debugLevel))
#define debug(debugLevel,codeToRun) ifDebug(debugLevel) then {codeToRun}
#define ifThen(cond,codeToRun) if (cond) then {codeToRun}

#define debugChat(chatText,debugLevel) debug(debugLevel, player sideChat chatText;)
#define debugChatC(chatText,debugLevel,cond) ifThen(cond,debugChat(chatText,debugLevel))

#define debugHint(hintText,debugLevel) debug(debugLevel, hint hintText;)
#define debugHintC(hintText,debugLevel,cond) ifThen(cond,debugHint(hintText,debugLevel))