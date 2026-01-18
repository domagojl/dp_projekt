"System Delta - Advanced Simulation" by Domagoj Lovosevic

[ --- 1. GLOBAL SETTINGS --- ]

A room can be powered or unpowered. A room is usually powered.
A room can be chilled or overheating. A room is usually chilled.

The player has a number called security-clearance. The security-clearance of the player is 0.
The oxygen level is a number that varies. The oxygen level is 20.
The server-temperature is a number that varies. The server-temperature is 20.
The air-leak-fixed is a truth state that varies. The air-leak-fixed is false.

[ --- 2. WORLD DEFINITION --- ]

The Central Lobby is a room. "The main hub. To the north is the Server Room. To the west is the Storage Unit."
The Storage Unit is west of the Central Lobby. "A room filled with spare parts, a broken air vent, and a nitrogen tank."
The Server Room is north of the Central Lobby. The Server Room is unpowered. "The server heart. It feels stuffy here."

The portable battery is in the Storage Unit.
The main generator is a device in the Central Lobby. It is fixed in place and switched off.
The Security Bot is a person in the Central Lobby.
The empty canister is in the Storage Unit.
The nitrogen tank is a scenery thing in the Storage Unit.
The coolant-mix is an object. 
The broken vent is a scenery thing in the Storage Unit.
The roll of duct tape is in the Storage Unit.

[ --- 3. ACTIONS DEFINITION --- ]

Using is an action applying to one thing.
Understand "use [something]" as using.

Repairing it with is an action applying to two things.
Understand "use [something] on [something]" as repairing it with.
Understand "repair [something] with [something]" as repairing it with.

Filling it from is an action applying to two things.
Understand "fill [something] from [something]" as filling it from.

Cooling is an action applying to one thing.
Understand "cool [something]" or "pour [something]" as cooling.

[ --- 4. COMPLEX LOGIC RULES --- ]

[ BLOKADA ULASKA ]
Instead of going north from the Central Lobby:
	if the Server Room is unpowered:
		say "The electronic lock on the Server Room door is dead. It needs power." instead;
	otherwise:
		continue the action.

[ SIMULACIJA KISIKA - SADA RADI I ISPISUJE SVAKI POTEZ ]
Every turn:
	if the air-leak-fixed is false:
		decrease the oxygen level by 1;
		say "OXYGEN LEVEL: [oxygen level] units. Air is leaking!";
		if the oxygen level is 0:
			say "You can't breathe... Everything goes dark.";
			end the story saying "You have died of asphyxiation.";
	otherwise:
		if the oxygen level < 20: [ Polako se vraća ako je popravljeno ]
			increase the oxygen level by 1.

[ LOGIKA TEMPERATURE - SADA JE AGRESIVNIJA ]
Every turn:
	if the main generator is switched on:
		now the Server Room is powered;
		if the Server Room is not chilled:
			increase the server-temperature by 15;
			say "WARNING: Server temperature is rising: [server-temperature]°C!";
		otherwise:
			decrease the server-temperature by 10;
			if the server-temperature < 20, now the server-temperature is 20;
			say "Cooling active. Temperature: [server-temperature]°C.";
	if the server-temperature > 90:
		say "THE SERVERS MELTED DOWN!";
		end the story saying "Hardware failure."

[ KEMIJSKA REAKCIJA ]
Instead of filling the empty canister from the nitrogen tank:
	now the player carries the coolant-mix;
	remove the empty canister from play;
	say "You fill the canister with liquid nitrogen, creating a coolant-mix."

[ POPRAVAK VENTILA ]
Instead of repairing the broken vent with the roll of duct tape:
	now the air-leak-fixed is true;
	say "You seal the crack. Oxygen levels stabilized.";
	remove the roll of duct tape from play.

[ HLAĐENJE ]
Instead of using the coolant-mix:
	if the player is in the Server Room:
		now the Server Room is chilled;
		now the server-temperature is 20;
		say "You pour the coolant into the system. Temperature stabilized.";
		remove the coolant-mix from play;
	otherwise:
		say "You should probably use this in the Server Room."

[ POWER LOGIC ]
Instead of inserting the portable battery into the main generator:
	now the main generator is switched on;
	now the Server Room is not chilled; [ Ovo pokreće grijanje ]
	now the security-clearance of the player is 1;
	say "Generator online! Security Level 1 granted.";
	remove the portable battery from play.

Understand "insert [something] into [something]" as inserting it into.

[ --- 5. WIN CONDITION --- ]

The main console is in the Server Room. 

Check using the main console:
	if the server-temperature > 40:
		say "The console is too hot to touch! Chill the servers first." instead.

Instead of using the main console:
	say "Final override successful! System Delta is stabilized.";
	end the story finally saying "Mission Accomplished!".