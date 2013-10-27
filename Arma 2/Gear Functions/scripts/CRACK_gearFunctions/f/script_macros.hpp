#define QUOTE(var) #var

#define defDir(localdir) QUOTE(scripts\CRACK_gearFunctions\localdir)

#define ifIsString(var) if (typeName(var) == typeName("HelloWorld"))
#define ifIsArray(var) if (typeName(var) == typeName([1,0]))

#define ifStringIsSet(var) if (var != "")
#define ifArrayIsSet(array) if (((array select 0) != "") AND ((array select 1) > 0) AND (((array select 1) % 1) == 0))