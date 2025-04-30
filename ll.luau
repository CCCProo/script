local Players = game:GetService("Players")

local function setupCharacter(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	while not humanoid or humanoid.Health <= 0 do
		character.ChildAdded:Wait()
		humanoid = character:FindFirstChildOfClass("Humanoid")
	end

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
			part.CollisionGroup = "Players"
		end
	end

	if character:FindFirstChild("HumanoidRootPart") then
		local rootPart = character.HumanoidRootPart

		humanoid:SetAttribute("MaxSpeed", 50)

		local lastPosition = rootPart.Position
		game:GetService("RunService").Heartbeat:Connect(function()
			local currentPosition = rootPart.Position
			local velocity = (currentPosition - lastPosition) * 60
			lastPosition = currentPosition

			if velocity.Magnitude > 100 then
				rootPart.Velocity = Vector3.new(0, 0, 0)
				rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			end
		end)
	end
end

game:GetService("PhysicsService"):RegisterCollisionGroup("Players")
game:GetService("PhysicsService"):CollisionGroupSetCollidable("Players", "Players", false)

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(setupCharacter)
end)

for _, player in ipairs(Players:GetPlayers()) do
	if player.Character then
		setupCharacter(player.Character)
	end
	player.CharacterAdded:Connect(setupCharacter)
end
