local WTDB = Watashi:NewModule("Watashi_DB", "AceEvent-3.0")
local WTDBrev = 27

function WTDB:Init(arg)
	WTDB.db = LibStub("AceDB-3.0"):New("WatashiDB")
	if arg == "init" then
		if WTDB.db.global then
			if WTDBrev > WTDB.db.global.rev then
				WTDB.db.global = nil
				WTDB:DBInit()
				DEFAULT_CHAT_FRAME:AddMessage("[Watashi_DB]: Updating database to rev."..WTDBrev)
			end
		end
		if not WTDB.db.global then
			WTDB:DBInit()
			DEFAULT_CHAT_FRAME:AddMessage("[Watashi_DB]: Initialize Database.")
		end
	elseif arg == "renew" then
		WTDB:DBInit()
		DEFAULT_CHAT_FRAME:AddMessage("[Watashi_DB]: Renew current Database.")
	end
end

function WTDB:DBInit()
	WTDB.db.global.ui = {
		[0] = {
			["frames"] = { "blue01", "blue02", "blue03", "blue04" },
			----------------//
			------ MINIMAP
			----------------//
			["map"] = {
				["scale"] = 1.09,
				["anchor"] = "BOTTOMRIGHT",
				["xOfs"] = -294.5,
				["yOfs"] = -3,
			},
			-----------------//
			------ PITBULL
			-----------------//
			["pitbull"] = {
				["scale"] = 1,
				[1] = {
					["name"] = "PitBull4_Frames_player",
					["anchor"] = "BOTTOMLEFT",
					["xOfs"] = 448,
					["yOfs"] = 54,
				},
				[2] = {
					["name"] = "PitBull4_Frames_target",
					["anchor"] = "BOTTOMRIGHT",
					["xOfs"] = -508,
					["yOfs"] = 54,
				},
				[3] = {
					["name"] = "PitBull4_Frames_focus",
					["anchor"] = "BOTTOMLEFT",
					["parent"] = "PitBull4_Frames_player",
					["xOfs"] = 0,
					["yOfs"] = -31,
				},
				[4] = {
					["name"] = "PitBull4_Frames_targettarget",
					["anchor"] = "BOTTOMLEFT",
					["parent"] = "PitBull4_Frames_target",
					["xOfs"] = 0,
					["yOfs"] = -31,
				},
			},
			---------------//
			----- SKADA
			---------------//
			["skada"] = {
				["scale"] = 0.875,
				[1] = {
					["name"] = "SkadaBarWindowThreat",
					["anchor"] = "BOTTOMRIGHT",
					["parent"] = "UIParent",
					["xOfs"] = -382,
					["yOfs"] = 198,
				},
				[2] = {
					["name"] = "SkadaBarWindowSkada",
					["anchor"] = "BOTTOMRIGHT",
					["parent"] = "SkadaBarWindowThreat",
					["xOfs"] = 204,
					["yOfs"] = 0,
				},
				[3] = {
					["name"] = "SkadaBarWindowHeal",
					["anchor"] = "BOTTOMRIGHT",
					["parent"] = "SkadaBarWindowSkada",
					["xOfs"] = 147,
					["yOfs"] = 0,
				},
			},
			["skadainit"] = {
				["WATASHI"] = {
					["modules"] = {
						["notankwarnings"] = true,
						["threattreshold"] = 90,
						["threatflash"] = true,
						["threatshake"] = true,
					},
					["windows"] = {
						["1"] = {
							["barheight"] = 14,
							["scale"] = 1,
							["barcolor"] = {
								["r"] = 0,
								["g"] = 0.7176470588235294,
								["b"] = 1,
							},
							["barfont"] = "CALIBRIB",
							["barslocked"] = true,
							["background"] = {
								["color"] = {
									["a"] = 0,
									["r"] = 1,
									["g"] = 1,
									["b"] = 1,
								},
								["height"] = 180,
								["texture"] = "HalBackground",
							},
							["bartexture"] = "HalU",
							["enablebackground"] = true,
							["y"] = 188,
							["x"] = -179,
							["title"] = {
								["font"] = "vibroceb",
								["fontsize"] = 14,
								["color"] = {
									["a"] = 0,
								},
								["texture"] = "Empty",
							},
							["baraltcolor"] = {
								["r"] = 0,
								["g"] = 0.4705882352941176,
								["b"] = 0.7490196078431373,
							},
							["point"] = "BOTTOMRIGHT",
							["barwidth"] = 190,
							["mode"] = "Damage",
						}, -- [1]
						["2"] = {
							["barheight"] = 14,
							["barmax"] = 10,
							["scale"] = 1,
							["barcolor"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0.5254901960784314,
								["r"] = 1,
							},
							["point"] = "BOTTOMRIGHT",
							["barfontsize"] = 11,
							["mode"] = "Threat",
							["modeincombat"] = "",
							["barslocked"] = true,
							["baraltcolor"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0.3294117647058824,
								["r"] = 0.8,
							},
							["barorientation"] = 1,
							["background"] = {
								["borderthickness"] = 0,
								["color"] = {
									["a"] = 0,
									["b"] = 0.5019607843137255,
									["g"] = 0,
									["r"] = 0,
								},
								["height"] = 180,
								["bordertexture"] = "None",
								["margin"] = 0,
								["texture"] = "HalBackground",
							},
							["set"] = "current",
							["title"] = {
								["borderthickness"] = 2,
								["font"] = "vibroceb",
								["fontsize"] = 14,
								["menubutton"] = true,
								["color"] = {
									["a"] = 0,
									["b"] = 0,
									["g"] = 0,
									["r"] = 0,
								},
								["bordertexture"] = "None",
								["margin"] = 0,
								["texture"] = "Empty",
							},
							["x"] = -382,
							["enablebackground"] = true,
							["spark"] = true,
							["bartexture"] = "HalU",
							["barwidth"] = 190,
							["barspacing"] = 0,
							["hidden"] = true,
							["returnaftercombat"] = false,
							["y"] = 188,
							["barfont"] = "CALIBRIB",
							["name"] = "Threat",
							["classcolorbars"] = true,
							["display"] = "bar",
							["enabletitle"] = true,
							["classcolortext"] = false,
							["reversegrowth"] = false,
						}, -- [2]
					},
				},
			},
			---------------//
			----- DOMINOS
			---------------//
			["dominos"] = {
				[1] = {
					["xOfs"] = 415,
					["yOfs"] = 137,
					["anchor"] = "BOTTOMLEFT",
					["scale"] = 1.05,
				},
				[2] = {
					["xOfs"] = -474,
					["yOfs"] = 137,
					["anchor"] = "BOTTOMRIGHT",
					["scale"] = 1.05,
				},
				[3] = {
					["xOfs"] = 415,
					["yOfs"] = 97,
					["anchor"] = "BOTTOMLEFT",
					["scale"] = 1.05,
				},
				[4] = {
					["xOfs"] = -474,
					["yOfs"] = 97,
					["anchor"] = "BOTTOMRIGHT",
					["scale"] = 1.05,
				},
				["class"] = {
					["xOfs"] = 560,
					["yOfs"] = 235,
					["anchor"] = "BOTTOMLEFT",
					["scale"] = 0.8,
				},
				["pet"] = {
					["xOfs"] = 660,
					["yOfs"] = 235,
					["anchor"] = "BOTTOMLEFT",
					["scale"] = 0.8,
				},
				["vehicle"] = {
					["xOfs"] = 790,
					["yOfs"] = 190,
					["anchor"] = "BOTTOMLEFT",
					["scale"] = 1,
				},
				["bags"] = {
					["xOfs"] = -210,
					["yOfs"] = 208,
					["anchor"] = "BOTTOMRIGHT",
					["scale"] = 1,
				},
				["menu"] = {
					["xOfs"] = -1,
					["yOfs"] = 260,
					["anchor"] = "BOTTOMRIGHT",
					["scale"] = 0.8,
				},
			},
			--------------//
			---- AZCASTBAR
			--------------//
			["azcastbar"] = {
				["scale"] = 1.05,
				[1] = {
					["name"] = "Player",
					["width"] = 182,
					["height"] = 12,
					["xOfs"] = 748,
					["yOfs"] = 226,
				},
				[2] = {
					["name"] = "Mirror",
					["width"] = 112,
					["height"] = 10.5,
					["xOfs"] = 783,
					["yOfs"] = 245,
				},
				[3] = {
					["name"] = "Focus",
					["width"] = 169,
					["height"] = 10.5,
					["xOfs"] = 755,
					["yOfs"] = 265,
				},
				[4] = {
					["name"] = "Target",
					["width"] = 219,
					["height"] = 16,
					["xOfs"] = 635,
					["yOfs"] = 92,
				},
			},
		},
	}
	WTDB.db.global.font = "Interface\\AddOns\\SharedMedia_MyMedia\\font\\vibrocreb.ttf"
	WTDB.db.global.dir = "Interface\\AddOns\\Watashi"
	WTDB.db.global.rev = WTDBrev
end
