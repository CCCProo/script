local rs = game:GetService("ReplicatedStorage")

for _, i in ipairs(workspace.Prav:GetChildren()) do
	i.ProximityPrompt.Triggered:Connect(function(player)
		
		local tool = rs["Axe Tool"]:Clone()
		tool.Value.Value = 1
		
		tool.Parent = player.Backpack or player.Character
		
	end)
end

for _, i in ipairs(workspace.Neitral:GetChildren()) do
	i.ProximityPrompt.Triggered:Connect(function(player)

		local tool = rs["Axe Tool"]:Clone()
		tool.Value.Value = 2

		tool.Parent = player.Backpack or player.Character

	end)
end

for _, i in ipairs(workspace.Virus:GetChildren()) do
	i.ProximityPrompt.Triggered:Connect(function(player)

		local tool = rs["Axe Tool"]:Clone()
		tool.Value.Value = 3

		tool.Parent = player.Backpack or player.Character

	end)
end
