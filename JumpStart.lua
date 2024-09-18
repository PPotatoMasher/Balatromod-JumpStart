--- STEAMODDED HEADER
--- MOD_NAME: Free Reroll and priceless joker for rounds 1 and 2
--- MOD_ID: JumpStart
--- MOD_AUTHOR: [PotatoMasher]
--- MOD_DESCRIPTION: Rerolls are free for stage 1 and 2, all joker cost $1. Based on FreeReroll mod by Tianjing

----------------------------------------------
------------MOD CODE -------------------------

local splash_screen_original = G.splash_screen
function G.splash_screen(self)
  -- Call the original splash_screen fonction
  local result = splash_screen_original(self)

    -- Save "real" Joker rarity
    originalRarityPool = G.P_JOKER_RARITY_POOLS
    self.P_JOKER_RARITY_POOLS = {
        {},{},{},{}
    }

    -- Save Joker cost
    originalJokerCost = {}

    -- Loop over jokers, insert into "1" rarity and modify cost to 0
    for k, v in pairs(self.P_CENTERS)
    do
        v.key = k        
        if v.rarity and v.set == 'Joker'
        then 
            originalJokerCost[v.order] = v.cost
            v.cost = 0
            table.insert(self.P_JOKER_RARITY_POOLS[1], v)
        end
    end

    return result
end

local joker_cost_restored = false
local calculate_reroll_cost_original = calculate_reroll_cost
function calculate_reroll_cost(skip_increment) 
  -- Call the original calculate_reroll_cost fonction
  calculate_reroll_cost_original(skip_increment)
  
  if G.GAME.round < 3 
  then
    -- Set the new reroll value if round 1 or 2
    G.GAME.current_round.reroll_cost = 0
  elseif not joker_cost_restored
  then
    -- Restore rarities and costs
    G.P_JOKER_RARITY_POOLS = originalRarityPool
    for k, v in pairs(G.P_CENTERS)
    do
        v.key = k        
        if v.rarity and v.set == 'Joker'
        then
            v.cost   = originalJokerCost[v.order]
        end
    end
    joker_cost_restored = true       
  end
end

----------------------------------------------
------------MOD CODE END----------------------