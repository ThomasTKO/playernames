nameDistance = _this select 0;
showDistance = _this select 1;

uisleep 10;
while {true} do
{
	_currentPlayerCount = count allPlayers;
	waitUntil {
		_currentPlayerCount > 1;
	};
	
	ShowPlayerNames = addMissionEventHandler ["Draw3D",
	{
		_players = allPlayers;
		{
			if (!(isNull _x) && (isPlayer _x) && (_x != player)) then
			{
				_distance = cameraOn distance _x;
				_alpha = (1-(_distance/nameDistance));
				_crew = crew (vehicle _x);
				_name = '';
				_name1 = '';
				_clr = [1, 1, 1, _alpha];				
				{
					if (_x != player) then
					{
						_name = format ['%3%1%2', ['', format ['%1, ', _name]] select (_name != ''), name _x, ['', format ['[%1] ', round(player distance _x)]] select (showDistance)];
					};
				} forEach _crew;	
				// for admin
				if ((getPlayerUID _x) in ["uid1"]) then
				{
					_name = format["ADMIN %1",_name];
					_clr = [1, 0, 0, _alpha];
				};
				// for mod 
				if ((getPlayerUID _x) in ["uid1","uid2"]) then
				{
					_name = format["MOD %1",_name];
					_clr = [0, 1, 0, _alpha];
				};
				_veh = vehicle _x;
				_bbr = boundingBoxReal _veh;
				_p1 = _bbr select 0;
				_p2 = _bbr select 1;
				_maxHeight = (abs ((_p2 select 2) - (_p1 select 2))) * 1.25; 
				_pos = visiblePosition _veh;
				_pos set[2,(_pos select 2) + _maxHeight];
				
				drawIcon3D['', _clr, _pos, 0, 0, 0, _name, 1, 0.03];
			};
		} forEach _players;
	}];

	_currentPlayerCount = count allPlayers;
	waitUntil {
		_currentPlayerCount != count allPlayers;
	};
	
	removeMissionEventHandler ["Draw3D", ShowPlayerNames];
	
	uisleep 1;
};