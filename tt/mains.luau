local Camera = workspace.CurrentCamera
local player = game:GetService('Players').LocalPlayer
local Character = player.Character


local RunService = game:GetService('RunService')

-- Функция для проверки, есть ли преграды между камерой и объектом
local function true_rey(part)
	local Parameters = RaycastParams.new()
	Parameters.FilterDescendantsInstances = {Character, part}
	Parameters.FilterType = Enum.RaycastFilterType.Blacklist

	local Vector, OnScreen = Camera:WorldToViewportPoint(part.Position)

	if OnScreen then
		if workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, Parameters) then
			return true -- Преграда есть
		else
			return false -- Преграды нет
		end
	else
		return false -- Объект не на экране
	end
end

-- Функция проверки и перемещения объектов
local function check_all(part, kk)
	if part:IsA("Model") and part:FindFirstChild("Humanoid") and player.Name ~= part.Name then
		local PrimaryPart = part.PrimaryPart

		if PrimaryPart then
			local tt = not true_rey(PrimaryPart)

			if kk then
				tt = true_rey(PrimaryPart)
			end

			if tt then
				if kk and part.Parent ~= workspace.Enemies then
					part.Parent = workspace.Enemies
				elseif not kk and part.Parent == workspace.Enemies then
					part.Parent = workspace
				end
			end
		end
	end
end

-- Основной цикл, проверяющий все объекты в workspace и Enemies
RunService.RenderStepped:Connect(function()
	for _, part in ipairs(workspace:GetChildren()) do
		check_all(part, true)
	end

	for _, part in ipairs(workspace.Enemies:GetChildren()) do
		check_all(part, false)
	end
end)
