--==============Северный скрипт================
--=======Помещать в ServerScript Service=======

local datastore = game:GetService("DataStoreService")
local CashSave = datastore:GetDataStore("CashLeaderstats")

local activePlayers = {}

local function add_cash_message(player: Player)
	activePlayers[player] = true

	while task.wait(3600) do
		
		local zp = 10000
		
		if not activePlayers[player] then return end

			player.leaderstats.Cash.Value += zp
			
			print("Мы выдали те 250 монет "..player.DisplayName)

			for _, player_get in ipairs(game.Players:GetPlayers()) do
				game.ReplicatedStorage.SendMessage:FireClient(player_get, player, zp)
			end
		end
	end

game.Players.PlayerAdded:Connect(function(player)

	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	local cash = Instance.new("IntValue", leaderstats)
	
	cash.Name = "Cash"
	cash.Value = CashSave:GetAsync(player.UserId) or 0

	add_cash_message(player)
end)

game.Players.PlayerRemoving:Connect(function(player) 
	activePlayers[player] = nil 
	CashSave:SetAsync(player.UserId, player.leaderstats.Cash.Value)
end)

--==============Локальный скрипт================
--=======Помещать в StarterPlayer Service=======

local players = game.Players
local player = players.LocalPlayer

local TextChatService = game:GetService("TextChatService")
local TextChannels = TextChatService:WaitForChild("TextChannels")

game.ReplicatedStorage.SendMessage.OnClientEvent:Connect(function(player_gets:Player, value: IntValue)
	
	TextChannels.RBXSystem:DisplaySystemMessage(player_gets.DisplayName .. " получил часовую зарплату в размере ".. value .. " монет")
	
end)
