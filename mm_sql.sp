#pragma semicolon 1
#include <sourcemod>
#include <sdktools>
#include <clientprefs>
#include <cstrike>

new Handle:hDb;

/*
* The database tables are: users, matches
[users]
username (varchar)
password (hashed varchar)
email (varchar)
steamid (string)
write up an API to check steamid for play time
the data returned would be in json format
If user joins the wrong match, instead of being kicked immediately
the server searches the database for any matching servers with their steamid and redirects them
*/

public Plugin:myinfo = {
	name = "DraftProSQL",
	author = "xrlk",
	description = "MySQL information framework.",
	version = "0.1",
	url = "https://csgodraftpro.com"
}

public OnPluginStart() {
	if(!connectMysqlDatabase()) {
        LogError("Unable to connect to mysql database.");
		PrintToServer("unsuccessful connection error");
	}
    else {
		LogError("Successfully connected to database.");
		PrintToServer("successful connection");
	}
}

public bool:connectMysqlDatabase() {
    if (hDb != INVALID_HANDLE)
        return true;
    
    //declarations
    decl String:error[255];
    new Handle:kv = CreateKeyValues("MySql");
    
    KvSetString(kv, "driver", "mysql");
    KvSetString(kv, "host", "localhost");
    KvSetString(kv, "database", "csgodraft2");
    KvSetString(kv, "user", "root");
    KvSetString(kv, "pass", "");
    
    hDb = SQL_ConnectCustom(kv, error, sizeof(error), true);
    LogMessage("successful connection");
    PrintToServer("successful connection");
    return hDb != INVALID_HANDLE;
}