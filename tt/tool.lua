local animation_id = 83185031265740
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://" .. tostring(animation_id)

local isPlaying = false

script.Parent.MouseButton1Up:Connect(function()
	print(isPlaying)
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
