local button = script.Parent

local player = game.Players.LocalPlayer

button.MouseButton1Up:Connect(function()
	
	local character = player.Character
	local backp = player.Backpack
	
	if backp:FindFirstChild("Name_items") then return end
	
	script.Parent.Parent.Visible = false
	
end)
