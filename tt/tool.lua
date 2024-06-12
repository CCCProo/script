local parent = script.Parent

local who_parent
local isEquipped = false

local function onTriggered(player)
	if not isEquipped then return end  -- Проверяем, надет ли инструмент

	who_parent = parent

	if not who_parent then return end

	if who_parent.Value.Value == 2 then return end

	if who_parent.Value.Value == 3 then 
		player:Kick("Вы словили Вирус!") 
		return 
	end

	player:Kick("Вы прошли игру!")
end

local function onEquipped()
	isEquipped = true
	workspace.Comp.ProximityPrompt.Triggered:Connect(onTriggered)
end

local function onUnequipped()
	isEquipped = false
end

parent.Equipped:Connect(onEquipped)
parent.Unequipped:Connect(onUnequipped)
