local BadgeService = game:GetService("BadgeService")
local BadgeId = 1403809845328587 -- Замените на свой ID бейджа

local function awardBadge(player)
    if not player then

        return
    end

    -- Проверяем, есть ли у игрока уже этот бейдж
    local hasBadge, hasBadgeErr = pcall(function()
        return BadgeService:UserHasBadgeAsync(player.UserId, BadgeId)
    end)
    
    if hasBadgeErr then

        return
    end

    if hasBadge then
        return
    end

    -- Если у игрока нет бейджа, пытаемся его выдать
    local success, awardErr = pcall(function()
        BadgeService:AwardBadge(player.UserId, BadgeId)
    end)
 
end

script.Parent.Touched:Connect(function(part)
    local character = part.Parent
    if character and character:FindFirstChild("Humanoid") then
        local player = game.Players:GetPlayerFromCharacter(character)
        if player then
            awardBadge(player)
        end
    end
end)
