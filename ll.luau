local MarketplaceService = game:GetService("MarketplaceService")
local BadgeService = game:GetService("BadgeService")
local Players = game:GetService("Players")

local badge_ids = {44, 44, 44}
local ugc_id = 0 
local already_prompted = {} 

Players.PlayerAdded:Connect(function(player)

    local function checkBadges()

        if already_prompted[player] then return end 

        local hasAllBadges = true

        for _, badgeId in ipairs(badge_ids) do

            local hasBadge = BadgeService:UserHasBadgeAsync(player.UserId, badgeId)
            if not hasBadge then

                hasAllBadges = false
                break
            end

        end

        if hasAllBadges then

            MarketplaceService:PromptPurchase(player, ugc_id)
            already_prompted[player] = true

        end
    end

    local connection = nil
    connection = player.CharacterAdded:Connect(function()

        while task.wait(1) do

            if not player:IsDescendantOf(Players) then

                connection:Disconnect()
                already_prompted[player] = nil
                return

            end
            checkBadges()

        end
    end)
end)