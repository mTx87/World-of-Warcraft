Watashi = LibStub( "AceAddon-3.0" ):NewAddon( "Watashi", "AceConsole-3.0", "AceEvent-3.0" )

local WT = Watashi
local WTDB, WTUI
local uiinit = false
local statsinit = false

function WT:OnInitialize()
	self:UnregisterAllEvents()
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("DISPLAY_SIZE_CHANGED")
	self:RegisterEvent("CVAR_UPDATE")
end

function Watashi:DBRenew()
	WTDB.db = nil
	WTDB:Init("renew")
end

function WT:OnEnable()
	WTDB = WT:GetModule("Watashi_DB")
	if WTDB then
		WTDB:Init("init")
	end
	WTUI = WT:GetModule("Watashi_UI")
end

function WT:OnDisable()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self:UnregisterEvent("PLAYER_LOGIN")
	self:UnregisterEvent("DISPLAY_SIZE_CHANGED")
	self:UnregisterEvent("CVAR_UPDATE")
end

function WT:PLAYER_LOGIN(...)
	if IsAddOnLoaded("Watashi_UI") then
		if WTUI then
			if (not uiinit) then
				uiinit = WTUI:Init()
			else
				WTUI:CombatStatus()
			end
		end
		if IsAddOnLoaded("Watashi_Stats") and statsinit == false then
			watashistats.__init()
			statsinit = 1
		end
	end
	if IsAddOnLoaded("Skada") and uiinit then
		WTUI:CombatStatus()
	end
end

function WT:PLAYER_REGEN_ENABLED(...)
	if IsAddOnLoaded("Watashi_UI") then
		WTUI:OutCombat()
	end
end

function WT:PLAYER_REGEN_DISABLED(...)
	if IsAddOnLoaded("Watashi_UI") then
		WTUI:InCombat()
	end
end

function WT:DISPLAY_SIZE_CHANGED(...)
	if IsAddOnLoaded("Watashi_UI") then
		if WTUI then
			if (not uiinit) then
				uiinit = WTUI:Init()
			else
				WTUI:CombatStatus()
			end
		end
	end
end

function WT:CVAR_UPDATE(cvar, value)
	if cvar == "uiScale" then
		local uicheck = false
		local _, valuecheck = WTUI:GetScales()
		if value == valuecheck then
			uicheck = true
		end
		if not uicheck then
			uiinit = WTUI:Init()
		end
	end
end