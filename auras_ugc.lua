local player_local = game.Players.LocalPlayer
local player_work = player_local.Character.HumanoidRootPart

local Teams = game:GetService("Teams")

farm = false
rebith = false

ballons = false

local function create_gui()
    local button

    local who = "HUD"

    local spawnFade = game.Players.LocalPlayer.PlayerGui:FindFirstChild(who)

    if not spawnFade then
        spawnFade = Instance.new("ScreenGui")
        spawnFade.Name = who
        spawnFade.Parent = playerGui
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
        button.Text = tostring(farm)
    end)
end

create_gui()

local function get_balance()
    local teams = Teams:GetTeams()
    local info 
    for _, team in pairs(teams) do
        local players = team:GetPlayers()
        if players then
            for _, player in pairs(players) do
                if player.Name == player_local.Name then
                    return player
                end
            end
        end
    end
end

local function cm(money_text) 
    local cleanedText = money_text:gsub("%$", ""):gsub(",", "")
    if cleanedText:find("M") then
        cleanedText = cleanedText:gsub("M", "")
        local number = tonumber(cleanedText)
        if number then
            cleanedText = tostring(number * 1e6)
        end
    end
    return cleanedText
end

local function getChest()

    if rebith == true then return end
    if ballons == true then return end

    for _,chest in ipairs(game.Workspace.Treasure.Chests:GetChildren()) do
        if chest:IsA("Part") then

            chests = true
            player_work.CFrame = chest.CFrame
            wait(1)
            chest.ProximityPrompt:InputHoldBegin()
            task.wait(chest.ProximityPrompt.HoldDuration)
            chest.ProximityPrompt:InputHoldEnd()
            chests = false

            wait(0.4)
            player_work.CFrame = collect_part
        end
    end
end

local function collect_balloon() 

    if rebith == true then return end
    if chests == true then return end

    for _, ball in ipairs(game.Workspace:GetChildren()) do
                    
        if ball.Name == "BalloonCrate" and ball:FindFirstChild("Crate") then

            ballons = true
            player_work.CFrame = ball.Crate.CFrame
            task.wait(0.5)

            prox = ball.Crate.ProximityPrompt
            fireproximityprompt(prox, prox.MaxActivationDistance)
            ballons = false

            player_work.CFrame = collect_part
                        
        end
        task.wait(0.5)
    end
end

while task.wait() do

    local drop

    local success, _ = pcall(function()

        local player_local = game.Players.LocalPlayer
        local player_work = player_local.Character.HumanoidRootPart

        if farm then

            if game.Workspace.Tycoons:FindFirstChild(player_local.Name) then

                if game.Workspace.Tycoons[player_local.Name].Auxiliary:FindFirstChild("Collector") then
                        
                    local buttons = game.Workspace.Tycoons[player_local.Name].Buttons
                    local balance = get_balance().leaderstats.Money.Value

                    local all_buttons = 0
                    for num, ab in ipairs(buttons:GetChildren()) do
                        all_buttons += 1
                    end

                    local collect_part = game.Workspace.Tycoons[player_local.Name].Auxiliary.Collector.Collect.CFrame
                    local success, _ = pcall(function()

                        if not game.Workspace.Tycoons[player_local.Name]:FindFirstChild("Auxiliary") and not game.Workspace.Tycoons[player_local.Name].Auxiliary:FindFirstChild("Rebirth") then
                            local args = {
                                [1] = "Darkness"
                            }

                            game:GetService("Players").LocalPlayer:WaitForChild("RemoteEvent"):FireServer(unpack(args))
                        end
                        if all_buttons == 0 and game.Workspace.Tycoons[player_local.Name]:FindFirstChild("Auxiliary") and game.Workspace.Tycoons[player_local.Name].Auxiliary:FindFirstChild("Rebirth") then
                            
                            rebith = true
                            local prox = game.workspace.Tycoons[player_local.Name].Auxiliary.Rebirth.Button

                            player_work.CFrame = prox.CFrame

                            rebith = true
                            task.wait(20)

                            prox.ProximityPrompt:InputHoldBegin()
                            task.wait(prox.ProximityPrompt.HoldDuraction)
                            prox.ProximityPrompt:InputHoldEnd()

                            task.wait(3)
                        end
                    end)

                    if all_buttons == 0 and game.Workspace.Tycoons[player_local.Name]:FindFirstChild("Auxiliary") and game.Workspace.Tycoons[player_local.Name].Auxiliary:FindFirstChild("Rebirth")  then
                        if success then return end
                    end
                    
                    if balance < 25000 then

                        coroutine.wrap(function()
                            collect_balloon()
                        end)()

                    end

                    for _, y in ipairs(buttons:GetChildren()) do

                        if y.Name:find("Traps") then drop = y end
                        if y.Name:find("Dropper") then
                            drop = y
                        end

                    end

                    local all_buttons = 0
                    for num, ab in ipairs(buttons:GetChildren()) do
                        all_buttons += 1
                    end

                    for _, i in ipairs(buttons:GetChildren()) do

                        if drop then
                            i = drop
                        end
                        
                        if i:FindFirstChild("Button") then
                            local price = tonumber(cm(i.Button.ButtonUI.TextLabel2.Text))   
                            
                            if farm then
                                if balance >= price then
                                    task.wait(0.3)
                                    player_work.CFrame = i["Button"].CFrame
                                    break
                                else
                                    player_work.CFrame = collect_part
                                    task.wait(2)
                                end
                            end
                        end
                    end
                end
            end
                task.wait(0.2)
        end
    end)
end
