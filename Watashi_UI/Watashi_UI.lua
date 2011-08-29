local WTUI = Watashi:NewModule("Watashi_UI", "AceConsole-3.0", "AceEvent-3.0")
local WTDB = Watashi:GetModule("Watashi_DB")

local frame = {}

function WTUI:Init()
	if table.getn(frame) < 1 and WTDB.db.global.ui then
		local temp
		local xScale, xUiScale = WTUI:GetScales()
		local uiscale = GetCVar("uiScale")
		local usescale = GetCVar("useUiScale")
    		if not usescale then
			SetCVar("useUiScale", "1")
		end
		if uiscale ~= xUiScale then
			SetCVar("uiScale", xUiScale)
			
			-- chatframes
			ChatFrame1:SetScale(1.05*xScale)
			ChatFrame2:SetScale(1.05*xScale)
			ChatFrame3:SetScale(1.05*xScale)
			
			-- sexymap
			if IsAddOnLoaded("SexyMap") then
				MinimapCluster:SetScale(WTDB.db.global.ui[0].map.scale*xScale)
				MinimapCluster:SetPoint(WTDB.db.global.ui[0].map.anchor, WTDB.db.global.ui[0].map.xOfs, WTDB.db.global.ui[0].map.yOfs)
			end
			
			-- Pitbull
			if IsAddOnLoaded("pitbull4") then
				for c=1,4 do
					temp = _G[WTDB.db.global.ui[0].pitbull[c].name]
					temp:SetScale(WTDB.db.global.ui[0].pitbull.scale*xScale)
					if c == 1 or c == 2 then
						temp:SetPoint(WTDB.db.global.ui[0].pitbull[c].anchor, WTDB.db.global.ui[0].pitbull[c].xOfs, WTDB.db.global.ui[0].pitbull[c].yOfs)
					else
						local parent = WTDB.db.global.ui[0].pitbull[c].parent
						temp:SetPoint(WTDB.db.global.ui[0].pitbull[c].anchor, WTDB.db.global.ui[0].pitbull[c].parent, WTDB.db.global.ui[0].pitbull[c].anchor, WTDB.db.global.ui[0].pitbull[c].xOfs, WTDB.db.global.ui[0].pitbull[c].yOfs)
					end
				end
			end		
			-- oUF
			if IsAddOnLoaded("oUF") and IsAddOnLoaded("Watashi_oUF") then
				oUF:Spawn('player', 'Watashi_oUF_Player'):SetPoint(WTDB.db.global.ui[0].pitbull[1].anchor, WTDB.db.global.ui[0].pitbull[1].xOfs, WTDB.db.global.ui[0].pitbull[1].yOfs)
				oUF:Spawn('pet', 'Watashi_oUF_Pet'):SetPoint('RIGHT', oUF.units.player, 'LEFT', -25, 0)
				oUF:Spawn('target', 'Watashi_oUF_Target'):SetPoint(WTDB.db.global.ui[0].pitbull[2].anchor, WTDB.db.global.ui[0].pitbull[2].xOfs, WTDB.db.global.ui[0].pitbull[2].yOfs)
				oUF:Spawn('targettarget', 'Watashi_oUF_TargetTarget'):SetPoint(WTDB.db.global.ui[0].pitbull[3].anchor, Watashi_oUF_Target, WTDB.db.global.ui[0].pitbull[3].anchor, WTDB.db.global.ui[0].pitbull[3].xOfs, WTDB.db.global.ui[0].pitbull[3].yOfs)
				oUF:Spawn('focus', 'Watashi_oUF_Focus'):SetPoint(WTDB.db.global.ui[0].pitbull[4].anchor, Watashi_oUF_Player, WTDB.db.global.ui[0].pitbull[4].anchor, WTDB.db.global.ui[0].pitbull[4].xOfs, WTDB.db.global.ui[0].pitbull[4].yOfs)
			end
			
			-- skada
			if IsAddOnLoaded("Skada") then
				local skadaprofile
				for i,v in pairs(SkadaDB.profileKeys) do
					if string.find(i, GetUnitName("player")) and string.find(i, GetRealmName("player")) then
						skadaprofile = v
						break
					end
				end
				if (not skadaprofile) then
					skadaprofile = "WATASHI"
				end
				for i in pairs(SkadaDB["profiles"][skadaprofile]["windows"]) do
					temp = _G[WTDB.db.global.ui[0].skada[i].name]
					if temp then
						temp:SetScale(WTDB.db.global.ui[0].skada.scale*xScale)
						temp:SetPoint(WTDB.db.global.ui[0].skada[i].anchor, WTDB.db.global.ui[0].skada[i].parent, WTDB.db.global.ui[0].skada[i].anchor, WTDB.db.global.ui[0].skada[i].xOfs, WTDB.db.global.ui[0].skada[i].yOfs)
					end
				end
			end

			-- dominos
			if IsAddOnLoaded("Dominos") then
				for i in pairs(WTDB.db.global.ui[0].dominos) do
					temp = Dominos.Frame:Get(i)
					if temp then
						temp:SetScale(WTDB.db.global.ui[0].dominos[i].scale*xScale)
						temp:SetPoint(WTDB.db.global.ui[0].dominos[i].anchor, WTDB.db.global.ui[0].dominos[i].xOfs, WTDB.db.global.ui[0].dominos[i].yOfs)
					end
				end
			end

			-- azcastbar
			if IsAddOnLoaded("AzCastbar") then
				for i=1,4 do
					temp = AzCastBar_Config[WTDB.db.global.ui[0].azcastbar[i].name]
					temp.left = WTDB.db.global.ui[0].azcastbar[i].xOfs*xScale
					temp.bottom = WTDB.db.global.ui[0].azcastbar[i].yOfs*xScale
					temp.width = WTDB.db.global.ui[0].azcastbar[i].width*xScale
					temp.height = WTDB.db.global.ui[0].azcastbar[i].height*xScale
				end
				AzCastBar.ApplyAllSettings()
			end
			
		end
    		for i,v in pairs(WTDB.db.global.ui[0].frames) do
        		local f = CreateFrame("Frame", v, UIParent)
        		f:SetFrameStrata("BACKGROUND")
        		f:SetWidth(512*xScale)
        		f:SetHeight(256*xScale)
        		local g = f:CreateTexture(nil, "BACKGROUND")
        		g:SetTexture(WTDB.db.global.dir.."_UI\\textures\\blue"..i)
        		g:SetAllPoints(f)
        		if i == 1 then
          	  		f:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0)
        		else
         	   		f:SetPoint("LEFT", WTDB.db.global.ui[0].frames[i-1], "RIGHT", 0, 0)
        		end
        		frame[i] = g
        		f:Show()
			end
			WorldFrame:SetPoint("BOTTOMRIGHT", 0, 256*xScale*xUiScale*(210/256)/100)
    	end
	self:CombatStatus()
	return true
end

function WTUI:CombatStatus()
	if InCombatLockdown() == 1 then
		self:InCombat()
	else
		self:OutCombat()
	end
end

function WTUI:OutCombat()
	if table.getn(frame) > 0 then
		for i in pairs(WTDB.db.global.ui[0].frames) do
			frame[i]:SetTexture(WTDB.db.global.dir.."_UI\\textures\\blue"..i)
		end
	end
	repeat
		MinimapCluster:Show()
	until MinimapCluster:IsShown() == 1
	if IsAddOnLoaded("Skada") then
		repeat
			SkadaBarWindowThreat:Hide()
		until SkadaBarWindowThreat:IsVisible() == nil
	end
end

function WTUI:InCombat()
	if table.getn(frame) > 0 then
		for i in pairs(WTDB.db.global.ui[0].frames) do
			frame[i]:SetTexture(WTDB.db.global.dir.."_UI\\textures\\red"..i)
		end
	end
	repeat
		MinimapCluster:Hide()
	until MinimapCluster:IsShown() == nil
	if IsAddOnLoaded("Skada") then
		repeat
			SkadaBarWindowThreat:Show()
		until SkadaBarWindowThreat:IsShown() == 1
	end
end

function WTUI:GetScales()
	local resolution = GetCVar("gxResolution")
	local i = string.find(resolution, "x")
	local w = string.sub(resolution, 0, i-1)
	local h = string.sub(resolution, i+1)
	local scale = 768/h
	local multi = w/1680
	--[[ neu, jede UIScale möglich
		local scale = 0.64
		local multi = UIParent:GetWidth()/1680
	]]--
	return multi, scale
end