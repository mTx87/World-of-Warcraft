local E, C, L, DB = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function()
	if C["others"].sellgrays then
		local c = 0
		for b=0,4 do
			for s=1,GetContainerNumSlots(b) do
				local l = GetContainerItemLink(b, s)
				if l then
					local p = select(11, GetItemInfo(l))*select(2, GetContainerItemInfo(b, s))
					if select(3, GetItemInfo(l))==0 and p>0 then
						UseContainerItem(b, s)
						PickupMerchantItem()
						c = c+p
					end
				end
			end
		end
		if c>0 then
			local g, s, c = math.floor(c/10000) or 0, math.floor((c%10000)/100) or 0, c%100
			DEFAULT_CHAT_FRAME:AddMessage(L.merchant_trashsell.." |cffffffff"..g..L.goldabbrev.." |cffffffff"..s..L.silverabbrev.." |cffffffff"..c..L.copperabbrev..".",255,255,0)
		end
	end
	if not IsShiftKeyDown() then
		if CanMerchantRepair() and C["others"].autorepair then
			local cost, possible = GetRepairAllCost()
			local c = cost%100
			local s = math.floor((cost%10000)/100)
			local g = math.floor(cost/10000)
			if C["others"].guildrepair then
				if cost > 0 then
					if possible then
						local BankMoney = GetGuildBankMoney()

						local BankWithdrawMoney = GetGuildBankWithdrawMoney()

						if CanGuildBankRepair() and BankMoney >= cost and (BankWithdrawMoney == -1 or BankWithdrawMoney >= cost) then

							RepairAllItems(1)

							DEFAULT_CHAT_FRAME:AddMessage(L.merchant_guildrepair.." |cffffffff"..g..L.goldabbrev.." |cffffffff"..s..L.silverabbrev.." |cffffffff"..c..L.copperabbrev..".", 255, 255, 0)

						else

							DEFAULT_CHAT_FRAME:AddMessage(L["Guild bank does not have enough money. Using yours."], 255, 255, 0)

							RepairAllItems()
							DEFAULT_CHAT_FRAME:AddMessage(L.merchant_repaircost.." |cffffffff"..g..L.goldabbrev.." |cffffffff"..s..L.silverabbrev.." |cffffffff"..c..L.copperabbrev..".",255,255,0)

						end
					else
						DEFAULT_CHAT_FRAME:AddMessage(L.merchant_guildnomoney,255,0,0)
					end
				end
			else
				if cost>0 then
					if possible then
						RepairAllItems()
						DEFAULT_CHAT_FRAME:AddMessage(L.merchant_repaircost.." |cffffffff"..g..L.goldabbrev.." |cffffffff"..s..L.silverabbrev.." |cffffffff"..c..L.copperabbrev..".",255,255,0)
					else
						DEFAULT_CHAT_FRAME:AddMessage(L.merchant_repairnomoney,255,0,0)
					end
				end
			end
		end
	end
end)
f:RegisterEvent("MERCHANT_SHOW")

-- buy max number value with alt
local savedMerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick
function MerchantItemButton_OnModifiedClick(self, ...)
	if ( IsAltKeyDown() ) then
		local maxStack = select(8, GetItemInfo(GetMerchantItemLink(self:GetID())))
		if ( maxStack and maxStack > 1 ) then
			BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID()))
		end
	end
	savedMerchantItemButton_OnModifiedClick(self, ...)
end