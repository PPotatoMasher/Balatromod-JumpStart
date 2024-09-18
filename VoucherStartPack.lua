--- STEAMODDED HEADER
--- MOD_NAME: Add essential vouchers to Every Run
--- MOD_ID: VoucherStartPack
--- MOD_AUTHOR: [PotatoMasher]
--- MOD_DESCRIPTION: Adds Overstock, Blank and Director's Cut Vouchers to all runs (also increase cost of advanded vouchers) based on PermanentOverstock mod by Encarvlucas

----------------------------------------------
------------MOD CODE -------------------------
local apply_to_run_original = Back.apply_to_run
-- Function used to apply new effects to runs
function Back.apply_to_run(arg)
    -- Call the original apply_to_run fonction
	apply_to_run_original(arg)
    
    -- Vouchers to apply
    local vouchers = {'v_overstock_norm','v_blank','v_directors_cut'}
    -- Vouchers cost to be increase for balancing
    local adv_vouchers = {'v_overstock_plus','v_antimatter','v_retcon'}
    local adv_vouchers_cost = 21

    -- Add voucher to run
    for key, value in pairs(vouchers)
    do
        G.GAME.used_vouchers[value] = true
        Card.apply_to_run(nil, G.P_CENTERS[value])
    end

    -- Increase advanced vouchers cost
    for key, value in pairs(adv_vouchers)
    do
        G.P_CENTERS[value].cost = adv_vouchers_cost
    end
end

----------------------------------------------
------------MOD CODE END----------------------