local ds = game:GetService("DataStoreService")
local bans_ds = ds:GetDataStore("Bans1")

local all_admin = {3134114276, 8901234}

local function handleChatMessage(player, message)
	
	local banned_or_kicked = false
	for _, id in all_admin do
		if tonumber(player.UserId) == tonumber(id) then
			banned_or_kicked = true
		end
	end
	if not banned_or_kicked then return end
	local lowerMessage = string.lower(message)
	if string.sub(lowerMessage, 1, 3) == "ban" then
		local words = {}
		for word in lowerMessage:gmatch("%S+") do
			table.insert(words, word)
		end

		if #words >= 3 then
			local startIndex = string.find(lowerMessage, "%s+" .. words[3] .. "%s+") + #words[3] + 1

			local reason = string.sub(message, startIndex)
			local name_banned = words[2]
			local timestamp = words[3]

			local player_id = game:GetService("Players"):GetUserIdFromNameAsync(name_banned)
			local player_name = game:GetService("Players"):GetNameFromUserIdAsync(player_id)

			bans_ds:SetAsync(player_id, {["reason"]=reason, ["timestamp"]=os.time() + timestamp})

			local bannedPlayer = game:GetService("Players"):FindFirstChild(player_name)
			if bannedPlayer then
				bannedPlayer:Kick("Ты забанен по причине " .. reason)
			end
		end
	elseif string.sub(lowerMessage, 1, 4) == "kick" then
		local words = {}
		for word in lowerMessage:gmatch("%S+") do
			table.insert(words, word)
		end

		if #words >= 2 then
			local startIndex = string.find(lowerMessage, "%s+" .. words[2] .. "%s+") + #words[2] + 1

			local reason = string.sub(message, startIndex)
			local name_banned = words[2]

			local player_id = game:GetService("Players"):GetUserIdFromNameAsync(name_banned)
			local player_name = game:GetService("Players"):GetNameFromUserIdAsync(player_id)

			local bannedPlayer = game:GetService("Players"):FindFirstChild(player_name)
			if bannedPlayer then
				bannedPlayer:Kick("Тебя кикнуло по причине " .. reason)
			end
		end
	end
end


game.Players.PlayerAdded:Connect(function(player)
	local plr_bans = bans_ds:GetAsync(player.UserId)
	if plr_bans then
		if tonumber(os.time()) < tonumber(plr_bans['timestamp']) then
			player:Kick(plr_bans['reason'])
		end
	end
	player.Chatted:Connect(function(msg)

		
		handleChatMessage(player, msg)
	end)
end)
