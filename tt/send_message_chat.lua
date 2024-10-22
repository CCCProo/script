local Tool = script.Parent
local partTemplate = game.ReplicatedStorage:WaitForChild("Part")
local throwSpeed = 25
local upwardForce = 50 
local rotationSpeed = 10

local time_set = true

local TweenService = game:GetService("TweenService")

local function killOnTouch(hit, player)
	print(hit.Name)
	if hit.Parent and hit.Parent.Name ~= player.Name then
		local humanoid = hit.Parent:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.Health = 0
		end
	end
end

local function randomRotation(part)
	part.CFrame = part.CFrame * CFrame.fromEulerAnglesXYZ(
		math.rad(rotationSpeed),
		math.rad(rotationSpeed),
		math.rad(rotationSpeed)
	)
end

local function tiltPart(part: Part)
	print(part.Orientation)

	local targetOrientation = Vector3.new(
		partTemplate.Orientation.Y, 
		part.Orientation.Y,  
		partTemplate.Orientation.Z  
	)

	local targetPosition = Vector3.new(part.Position.X, (workspace.Baseplate.Position.Y + workspace.Baseplate.Size.Y / 2 + (part.Size.Y / 2)), part.Position.Z)

	print(targetPosition)
	print(workspace.Baseplate.Position)

	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

	local orientationTween = TweenService:Create(part, tweenInfo, {Orientation = targetOrientation})
	local positionTween = TweenService:Create(part, tweenInfo, {Position = targetPosition})

	orientationTween:Play()
	positionTween:Play()
end


local function throwMesh(player)
	local character = player.Character
	if character then
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then

			local part = partTemplate:Clone()
			part.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, -5)  
			part.Parent = workspace

			part.Touched:Connect(function(hit)
				killOnTouch(hit, player)
			end)

			local bodyVelocity = Instance.new("BodyVelocity", part)
			bodyVelocity.Velocity = humanoidRootPart.CFrame.LookVector * throwSpeed + Vector3.new(0, upwardForce, 0)
			bodyVelocity.MaxForce = Vector3.new(1000, 1000, 1000)

			part.Touched:Connect(function(hit)
				if hit:IsA("BasePart") and hit.Name == "Baseplate" then

					bodyVelocity.Velocity = Vector3.new(0, 0, 0) 
					part.Anchored = true 

					task.wait(0.1)
					if bodyVelocity then
						bodyVelocity:Destroy()
					end

					tiltPart(part)
				end
			end)


			local rotationConnection
			rotationConnection = game:GetService("RunService").Stepped:Connect(function()
				if part and part.Parent and not part.Anchored then  
					randomRotation(part)
				else
					rotationConnection:Disconnect()
				end
			end)
		end
	end
end

Tool.Activated:Connect(function()
	local player = game.Players:GetPlayerFromCharacter(Tool.Parent)
	if player and time_set then
		throwMesh(player)
		time_set = false
		
		task.wait(10)
		time_set = true
	end
end)
