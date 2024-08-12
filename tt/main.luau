local RunService = game:GetService("RunService")
local work = game:GetService("Workspace")

local build_pack = work.BuildPack

local all_gold = build_pack.Resources

local player = game.Players.LocalPlayer
local character = player.Character

local farm = false

local function create_gui()
    local button

    local who = "GUI"

    local spawnFade = game.Players.LocalPlayer.PlayerGui:FindFirstChild(who)

    if not spawnFade then
        spawnFade = Instance.new("ScreenGui")
        spawnFade.Name = who
        spawnFade.Parent = game.Players.LocalPlayer.PlayerGui
    end

    if not spawnFade:FindFirstChild("Button") then
        button = Instance.new("TextButton")
        button.Parent = spawnFade

        button.Position = UDim2.new(0, 20, 0.81, 0)
        button.Size = UDim2.new(0.2, 0, 0.1, 0)
    else
        button = spawnFade:FindFirstChild("Button")
    end
    button.MouseButton1Click:Connect(function()
        farm = not farm
        if farm then
            button.Text = "Работает"
        else 
            button.Text = "Не работает"
        end
    end)
end

create_gui()

local function collect_all_gold()
    if farm then

        for _, gold in ipairs(all_gold:GetChildren()) do

            if farm then
                character.PrimaryPart.CFrame = gold.CFrame
            end
        end

    end

end

RunService.Stepped:Connect(collect_all_gold)