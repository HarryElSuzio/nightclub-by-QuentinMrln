Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.PrixFlyers                 = 3
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.Locale                     = 'fr'

Config.Zones = {

	AbsintheFarm = {
		Pos   = {x = 2744.922, y = 1487.379, z = 29.822},
		Size  = {x = 2.0, y = 2.0, z = 1.0},
		Color = {r = 0, g = 255, b = 0},
		Name  = "Récupération de papier",
		Type  = 25
	},

	TraitementMdlm = {
		Pos   = {x = -1328.466, y = -402.020, z = 35.633},
		Size  = {x = 2.0, y = 2.0, z = 1.0},
		Color = {r = 0, g = 255, b = 0},
		Name  = "Sous traitage des flyers",
		Type  = 25
	},
	
	SellFarm = {
		Pos   = {x = -451.260, y = -2802.958, z = 5.030},
		Size  = {x = 2.0, y = 2.0, z = 1.0},
		Color = {r = 0, g = 255, b = 0},
		Name  = "Livraison des flyers",
		Type  = 25
	},

	PalaceActions = {
		Pos   = {x = -1619.133, y = -3011.152, z = -76.175},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 255, b = 0},
		Name  = "Point d'action",
		Type  = 27
	 },
	  
	VehicleSpawner = {
		Pos   = {x = -1622.327, y = -3019.310, z = -76.175},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 255, b = 0},
		Name  = "Garage véhicule",
		Type  = 27
	},

	VehicleSpawnPoint = {
		Pos   = {x = -1639.769, y = -3010.993, z = -79.144},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 255, b = 0},
		Name  = "Spawn point",
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = {x = -1639.769, y = -3010.993, z = -79.114},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 0, g = 255, b = 0},
		Name  = "Ranger son véhicule",
		Type  = 27
	},

	Shop = {
		Pos   = { x = -1583.051, y = -3014.080, z = -76.975 },
        Size  = { x = 1.5, y = 1.5, z = 0.0 },
        Color = {r = 0, g = 255, b = 0},
        Type  = 1,
        Items = {
			{ name = 'adiosmotherfucker', label = '🍸 Adios Motherfucker',   price = 3 },
			{ name = 'bacardicocktail', label = '🍸 Bacardi Cocktail',       price = 3 },
			{ name = 'cajuamigo', label = '🍸 Caju Amigo', 				     price = 3 },
			{ name = 'douxbaisers', label = '🍸 Doux Baisers', 			     price = 3 },
			{ name = 'episcopale', label = '🍸 Episcopale', 			     price = 3 },
			{ name = 'flamingdrpepper', label = '🍸 Flaming Dr. Pepper',     price = 3 },
			{ name = 'grasshopper', label = '🍸 Grasshopper', 			     price = 3 },
			{ name = 'harveywallbanger', label = '🍸 Harvey Wallbanger',     price = 3 },
			{ name = 'irishcoffee', label = '🍸 Irish Coffee', 			     price = 3 },
			{ name = 'jacqueline', label = '🍸 Jacqueline', 			     price = 3 },
			{ name = 'kirroyal', label = '🍸 Kir Royal', 				     price = 3 },
			{ name = 'longislandicedtea', label = '🍸 Long Island Iced Tea', price = 3 },
			{ name = 'manhattan', label = '🍸 Manhattan', 					 price = 3 },
			{ name = 'negroni', label = '🍸 Negroni', 						 price = 3 },
			{ name = 'oldfashioned', label = '🍸 Old fashioned', 			 price = 3 },
			{ name = 'pinklady', label = '🍸 Pink Lady', 					 price = 3 },
			{ name = 'quentao', label = '🍸 Quentão', 						 price = 3 },
			{ name = 'rabodegalo', label = '🍸 Rabo de galo', 				 price = 3 },
			{ name = 'sangria', label = '🍸 Sangria', 						 price = 3 },
			{ name = 'tequilasunrise', label = '🍸 Tequila Sunrise', 		 price = 3 },
			{ name = 'vesper', label = '🍸 Vesper', 						 price = 3 },
			{ name = 'whiskyhighball', label = '🍸 Whisky Highball', 		 price = 3 },
			{ name = 'zombie', label = '🍸 Zombie', 						 price = 3 },
        },
	}
}