--------------------------------------------------------------------------------
------------------------------------------------- Completed by JalalLinuX ------
--------------------------------------------------------------------------------


-----------------------------
------ Event Handlers -------
-----------------------------
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
	local player = source
    deferrals.defer()
	Wait(0)
	deferrals.update(string.format("Hello %s, Your Steam ID is being checked.", name))
	Wait(0)
    if not GetIDFromSource('steam', player) then
        deferrals.done("You are not connected to Steam.")
    else
		deferrals.done()
		local messageContent = "**- Player Id** : "..player.."\n**- Player Name** : "..name.."\n**- SteamHex** : steam:"..GetIDFromSource('steam', player)
		sendToDiscord(Config.WebhooksUrl.System, Config.SystemAvatar, 'Connected\n:inbox_tray:', messageContent, 6415476)
	end
end)

AddEventHandler('playerDropped', function(Reason)
	local player = source
	local messageContent = "**- Player Id** : "..player.."\n**- Player Name** : "..GetPlayerName(player).."\n**- SteamHex** : steam:"..GetIDFromSource('steam', player)
	sendToDiscord(Config.WebhooksUrl.System, Config.SystemAvatar, 'Disonnected\n:outbox_tray:', messageContent, 16711680)
end)

RegisterServerEvent('JLDiscord:PlayerDied')
AddEventHandler('JLDiscord:PlayerDied', function(Reason, ReasonHash, Killer, Weapon)
	Weapon = Weapon and Weapon or ''
	Killer = Killer and Killer or ''
	Reason = Reason and Reason or ''
	
	local date = os.date('*t')
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	local DateString = date.year .. '/' .. date.month .. '/' .. date.day .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec
	
	local messageContent = "**- Player Id** : "..source.."\n**- Player Name** : "..GetPlayerName(source).."\n**- SteamHex** : steam:"..GetIDFromSource('steam', source).."\n**- Killer** : "..Killer.."\n**- Weapon** : "..Weapon.."\n**- Reason** : "..Reason.."\n**- Reason Hash** : "..ReasonHash.."\n**- DateTime** : "..DateString
	sendToDiscord(Config.WebhooksUrl.Kill, Config.SystemAvatar, 'Kill Log\n:skull_crossbones:', messageContent, 15495465)
end)

AddEventHandler('chatMessage', function(Source, Name, Message)
	local messageContent = "**- Player Id** : "..Source.."\n**- Player Name** : "..Name.."\n**- SteamHex** : steam:"..GetIDFromSource('steam', Source).."\n**- Chat** : "..Message
	sendToDiscord(Config.WebhooksUrl.Chat, Config.SystemAvatar, 'Chat Log\n:page_facing_up:', messageContent, 65535)
end)



-----------------------------
--------- Functions ---------
-----------------------------
function sendToDiscord(webhookUrl, avatar, title, message, color)
	local connect = {
		{
		  	["color"] = color,
		  	["title"] = "**".. title .."**\n",
			["description"] = message,
			["footer"] = {
				["text"] = ". . . . . . . . . . . . . . . . . . .\nMade by JalalLinuX",
			},
		  }
	  }
	PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({username = Config.SystemName, embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
end

function IsCommand(String, Type)
	if Type == 'Blacklisted' then
		for Key, BlacklistedCommand in ipairs(Config.BlacklistedCommands) do
			if String[1]:lower() == BlacklistedCommand:lower() then
				return true
			end
		end
	elseif Type == 'Special' then
		for Key, SpecialCommand in ipairs(Config.SpecialCommands) do
			if String[1]:lower() == SpecialCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'HavingOwnWebhook' then
		for Key, OwnWebhookCommand in ipairs(Config.OwnWebhookCommands) do
			if String[1]:lower() == OwnWebhookCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'TTS' then
		for Key, TTSCommand in ipairs(Config.TTSCommands) do
			if String[1]:lower() == TTSCommand:lower() then
				return true
			end
		end
	elseif Type == 'Registered' then
		local RegisteredCommands = GetRegisteredCommands()
		for Key, RegisteredCommand in ipairs(GetRegisteredCommands()) do
			if String[1]:lower():gsub('/', '') == RegisteredCommand.name:lower() then
				return true
			end
		end
	end
	return false
end

function ReplaceSpecialCommand(String)
	print('x x x '..String)
	for i, SpecialCommand in ipairs(Config.SpecialCommands) do
		if String[1]:lower() == SpecialCommand[1]:lower() then
			String[1] = SpecialCommand[2]
		end
	end
	return String
end

function GetOwnWebhook(String)
	for i, OwnWebhookCommand in ipairs(Config.OwnWebhookCommands) do
		if String[1]:lower() == OwnWebhookCommand[1]:lower() then
			if OwnWebhookCommand[2] == 'WEBHOOK_LINK_HERE' then
				print('Please enter a webhook link for the command: ' .. String[1])
				return Config.WebhooksUrl.Chat
			else
				return OwnWebhookCommand[2]
			end
		end
	end
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	local t={} ; i=1
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	return t
end


function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
	if ID and GetPlayerIdentifiers(ID) then
		local IDs = GetPlayerIdentifiers(ID)
		for _, CurrentID in pairs(IDs) do
			local ID = stringsplit(CurrentID, ':')
			if (ID[1]:lower() == string.lower(Type)) then
				return ID[2]:lower()
			end
		end
	end
    return nil
end

	
-----------------------------
---- System Start Alert -----
-----------------------------
sendToDiscord(Config.WebhooksUrl.System, Config.SystemAvatar, 'Started\n:robot:', 'FiveM server webhook manager started by **JLDiscord**', 16318463)
