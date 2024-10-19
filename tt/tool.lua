local animation_id = 83185031265740
local player = game.Players.LocalPlayer

local isPlaying = false

for _, button in ipairs(script.Parent.Buttons:GetChildren()) do
	
	print(button)
	
	button.MouseButton1Up:Connect(function()
		
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")
		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://" .. tostring(button.IdAnimation.Value)
				
		if not isPlaying then
			isPlaying = true

			local animator = humanoid:FindFirstChildOfClass("Animator")
			local animationTrack = animator:LoadAnimation(animation)
			animationTrack:Play()

			animationTrack.Stopped:Connect(function()
				isPlaying = false
			end)
			
		end
		
	end)
end
