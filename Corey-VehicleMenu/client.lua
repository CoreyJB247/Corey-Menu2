-- client.lua - Converted to ox_lib menu
local replaceVehicle = true
local savedVehicles = {}
local noHelmet = false
local engineAlwaysOn = false
local alwaysClean = false

CreateThread(function()
    local loaded = GetResourceKvpString('vehicle_menu_saved_vehicles')
    if loaded then
        savedVehicles = json.decode(loaded) or {}
        print('[Vehicle Menu] Loaded ' .. #savedVehicles .. ' saved vehicles')
    end
end)

local function SaveVehiclesToKVP()
    SetResourceKvp('vehicle_menu_saved_vehicles', json.encode(savedVehicles))
end

local vehicles = {
    {
        category = "Super", 
        icon = "gauge-high", 
        iconColor = "#FF00FF", 
        models = {
            {model = "adder", name = "Adder"},
            {model = "autarch", name = "Autarch"},
            {model = "banshee2", name = "Banshee 900R"},
            {model = "bullet", name = "Bullet"},
            {model = "cheetah", name = "Cheetah"},
            {model = "cyclone", name = "Cyclone"},
            {model = "entityxf", name = "Entity XF"},
            {model = "fmj", name = "FMJ"},
            {model = "infernus", name = "Infernus"},
            {model = "italigtb", name = "Itali GTB"},
            {model = "nero", name = "Nero"},
            {model = "osiris", name = "Osiris"},
            {model = "pfister811", name = "Pfister 811"},
            {model = "reaper", name = "Reaper"},
            {model = "sc1", name = "SC1"},
            {model = "sultanrs", name = "Sultan RS"},
            {model = "t20", name = "T20"},
            {model = "turismor", name = "Turismo R"},
            {model = "tyrus", name = "Tyrus"},
            {model = "vacca", name = "Vacca"},
            {model = "visione", name = "Visione"},
            {model = "voltic", name = "Voltic"},
            {model = "zentorno", name = "Zentorno"}
        }
    },
    {
        category = "Sports", 
        icon = "flag-checkered", 
        iconColor = "#FF4500", 
        models = {
            {model = "alpha", name = "Alpha"},
            {model = "banshee", name = "Banshee"},
            {model = "bestiagts", name = "Bestia GTS"},
            {model = "blista2", name = "Blista Compact"},
            {model = "buffalo", name = "Buffalo"},
            {model = "buffalo2", name = "Buffalo S"},
            {model = "carbonizzare", name = "Carbonizzare"},
            {model = "comet2", name = "Comet"},
            {model = "coquette", name = "Coquette"},
            {model = "elegy", name = "Elegy RH8"},
            {model = "elegy2", name = "Elegy Retro"},
            {model = "feltzer2", name = "Feltzer"},
            {model = "furoregt", name = "Furore GT"},
            {model = "fusilade", name = "Fusilade"},
            {model = "futo", name = "Futo"},
            {model = "jester", name = "Jester"},
            {model = "khamelion", name = "Khamelion"},
            {model = "kuruma", name = "Kuruma"},
            {model = "lynx", name = "Lynx"},
            {model = "massacro", name = "Massacro"},
            {model = "ninef", name = "9F"},
            {model = "penumbra", name = "Penumbra"},
            {model = "raiden", name = "Raiden"},
            {model = "rapidgt", name = "Rapid GT"},
            {model = "raptor", name = "Raptor"},
            {model = "revolter", name = "Revolter"},
            {model = "schafter3", name = "Schafter V12"},
            {model = "seven70", name = "Seven-70"},
            {model = "specter", name = "Specter"},
            {model = "surano", name = "Surano"}
        }
    },
    {
        category = "Sedans", 
        icon = "car", 
        iconColor = "#4169E1", 
        models = {
            {model = "asea", name = "Asea"},
            {model = "asterope", name = "Asterope"},
            {model = "cog55", name = "Cognoscenti 55"},
            {model = "cognoscenti", name = "Cognoscenti"},
            {model = "emperor", name = "Emperor"},
            {model = "fugitive", name = "Fugitive"},
            {model = "glendale", name = "Glendale"},
            {model = "ingot", name = "Ingot"},
            {model = "intruder", name = "Intruder"},
            {model = "premier", name = "Premier"},
            {model = "primo", name = "Primo"},
            {model = "primo2", name = "Primo Custom"},
            {model = "regina", name = "Regina"},
            {model = "schafter2", name = "Schafter"},
            {model = "stanier", name = "Stanier"},
            {model = "stratum", name = "Stratum"},
            {model = "stretch", name = "Stretch"},
            {model = "superd", name = "Super Diamond"},
            {model = "surge", name = "Surge"},
            {model = "tailgater", name = "Tailgater"},
            {model = "warrener", name = "Warrener"},
            {model = "issi8", name = "Issi Rally"},
            {model = "washington", name = "Washington"}
        }
    },
    {
        category = "SUVs", 
        icon = "truck", 
        iconColor = "#228B22", 
        models = {
            {model = "baller", name = "Baller"},
            {model = "baller2", name = "Baller LE"},
            {model = "baller8", name = "Baller ST-D"},
            {model = "cavalcade", name = "Cavalcade"},
            {model = "cavalcade2", name = "Cavalcade II"},
            {model = "dubsta", name = "Dubsta"},
            {model = "dubsta2", name = "Dubsta 2"},
            {model = "fq2", name = "FQ 2"},
            {model = "granger", name = "Granger"},
            {model = "granger2", name = "Granger 3600LX"},
            {model = "gresley", name = "Gresley"},
            {model = "habanero", name = "Habanero"},
            {model = "huntley", name = "Huntley S"},
            {model = "landstalker", name = "Landstalker"},
            {model = "landstalker2", name = "Landstalker XL"},
            {model = "mesa", name = "Mesa"},
            {model = "patriot", name = "Patriot"},
            {model = "radi", name = "Radius"},
            {model = "rocoto", name = "Rocoto"},
            {model = "seminole", name = "Seminole"},
            {model = "serrano", name = "Serrano"},
            {model = "xls", name = "XLS"},
            {model = "iwagen", name = "I-Wagen"},
            {model = "jubilee", name = "Jubilee"},
            {model = "dorado", name = "Dorado"},
        }
    },
    {
        category = "Coupes", 
        icon = "gem", 
        iconColor = "#DAA520", 
        models = {
            {model = "cogcabrio", name = "Cognoscenti Cabrio"},
            {model = "exemplar", name = "Exemplar"},
            {model = "f620", name = "F620"},
            {model = "felon", name = "Felon"},
            {model = "felon2", name = "Felon GT"},
            {model = "jackal", name = "Jackal"},
            {model = "oracle", name = "Oracle"},
            {model = "oracle2", name = "Oracle XS"},
            {model = "sentinel", name = "Sentinel"},
            {model = "sentinel2", name = "Sentinel XS"},
            {model = "windsor", name = "Windsor"},
            {model = "windsor2", name = "Windsor Drop"},
            {model = "zion", name = "Zion"},
            {model = "zion2", name = "Zion Cabrio"}
        }
    },
    {
        category = "Muscle", 
        icon = "fire", 
        iconColor = "#DC143C", 
        models = {
            {model = "blade", name = "Blade"},
            {model = "buccaneer", name = "Buccaneer"},
            {model = "buccaneer2", name = "Buccaneer Custom"},
            {model = "chino", name = "Chino"},
            {model = "chino2", name = "Chino Custom"},
            {model = "clique", name = "Clique"},
            {model = "coquette3", name = "Coquette BlackFin"},
            {model = "deviant", name = "Deviant"},
            {model = "dominator", name = "Dominator"},
            {model = "dominator2", name = "Dominator GTX"},
            {model = "dukes", name = "Dukes"},
            {model = "gauntlet", name = "Gauntlet"},
            {model = "gauntlet2", name = "Gauntlet Classic"},
            {model = "hermes", name = "Hermes"},
            {model = "hotknife", name = "Hotknife"},
            {model = "faction", name = "Faction"},
            {model = "faction2", name = "Faction Custom"},
            {model = "nightshade", name = "Nightshade"},
            {model = "phoenix", name = "Phoenix"},
            {model = "picador", name = "Picador"},
            {model = "ratloader", name = "Rat-Loader"},
            {model = "ruiner", name = "Ruiner"},
            {model = "sabregt", name = "Sabre Turbo"},
            {model = "slamvan", name = "Slamvan"},
            {model = "slamvan2", name = "Lost Slamvan"},
            {model = "stalion", name = "Stallion"},
            {model = "tampa", name = "Tampa"},
            {model = "vigero", name = "Vigero"},
            {model = "virgo", name = "Virgo"},
            {model = "voodoo", name = "Voodoo"},
            {model = "yosemite", name = "Yosemite"}
        }
    },
    {
        category = "Off-Road", 
        icon = "mountain", 
        iconColor = "#8B4513", 
        models = {
            {model = "bfinjection", name = "BF Injection"},
            {model = "bifta", name = "Bifta"},
            {model = "blazer", name = "Blazer"},
            {model = "brawler", name = "Brawler"},
            {model = "dubsta3", name = "Dubsta 6x6"},
            {model = "dune", name = "Dune Buggy"},
            {model = "guardian", name = "Guardian"},
            {model = "insurgent", name = "Insurgent"},
            {model = "insurgent2", name = "Insurgent Pick-Up"},
            {model = "kalahari", name = "Kalahari"},
            {model = "kamacho", name = "Kamacho"},
            {model = "marshall", name = "Marshall"},
            {model = "mesa3", name = "Mesa (Off-Road)"},
            {model = "monster", name = "Monster Truck"},
            {model = "rancher", name = "Rancher XL"},
            {model = "rebel", name = "Rebel"},
            {model = "rebel2", name = "Rusty Rebel"},
            {model = "riata", name = "Riata"},
            {model = "sandking", name = "Sandking XL"},
            {model = "sandking2", name = "Sandking SWB"},
            {model = "technical", name = "Technical"},
            {model = "trophytruck", name = "Trophy Truck"},
            {model = "guardian", name = "Vapid Guardian"},
            {model = "trophytruck2", name = "Desert Raid"}
        }
    },
    {
        category = "Vans", 
        icon = "van-shuttle", 
        iconColor = "#ccc8c8ff", 
        models = {
            {model = "bison", name = "Bison"},
            {model = "bobcatxl", name = "Bobcat XL"},
            {model = "boxville", name = "Boxville"},
            {model = "burrito", name = "Burrito"},
            {model = "burrito2", name = "Burrito (Gang)"},
            {model = "burrito3", name = "Burrito (Snow)"},
            {model = "gburrito", name = "Gang Burrito"},
            {model = "gburrito2", name = "Gang Burrito 2"},
            {model = "minivan", name = "Minivan"},
            {model = "minivan2", name = "Minivan Custom"},
            {model = "paradise", name = "Paradise"},
            {model = "pony", name = "Pony"},
            {model = "pony2", name = "Pony (Weed)"},
            {model = "rumpo", name = "Rumpo"},
            {model = "rumpo2", name = "Rumpo (Deludamol)"},
            {model = "rumpo3", name = "Rumpo Custom"},
            {model = "speedo", name = "Speedo"},
            {model = "speedo2", name = "Speedo (Clown)"},
            {model = "surfer", name = "Surfer"},
            {model = "surfer2", name = "Surfer (Rusty)"},
            {model = "taco", name = "Taco Van"},
            {model = "youga", name = "Youga"},
            {model = "youga2", name = "Youga Classic"}
        }
    },
    {
        category = "Commercial", 
        icon = "truck", 
        iconColor = "#eb4646ff", 
        models = {
            {model = "benson", name = "Benson"},
            {model = "benson2", name = "Benson (Cluckin' Bell)"},
            {model = "biff", name = "Biff"},
            {model = "cerberus", name = "Apocalypse Cerberus"},
            {model = "cerberus2", name = "Future Shock Cerberus"},
            {model = "cerberus3", name = "Nightmare Cerberus"},
            {model = "hauler", name = "Hauler"},
            {model = "hauler2", name = "Hauler Custom"},
            {model = "mule", name = "Mule"},
            {model = "mule4", name = "Mule Custom"},
            {model = "packer", name = "Packer"},
            {model = "phantom", name = "Phantom"},
            {model = "phantom2", name = "Phantom Wedge"},
            {model = "phantom3", name = "Phantom Custom"},
            {model = "phantom4", name = "Phantom XMAS"},
            {model = "pounder", name = "Pounder"},
            {model = "pounder2", name = "Pounder Custom"},
            {model = "stockade", name = "Stockade"},
            {model = "terbyte", name = "Terrorbyte"},
            {model = "docktug", name = "Docktug"},
            {model = "tractor2", name = "Fieldmaster Tractor"},
            {model = "utillitruck", name = "Utility Truck (Lift)"},
            {model = "utillitruck2", name = "Utility Truck"},
            {model = "utillitruck3", name = "Utility Car"},
            {model = "handler", name = "Dock Handler"},
            {model = "mixer", name = "Cement Mixer"},
            {model = "rubble", name = "Rubble Truck"},
            {model = "tiptruck", name = "Tipper"},
            {model = "tiptruck2", name = "Tipper 2"},
            {model = "trash", name = "Garbage Truck"},

        }
    },
    {
        category = "Service", 
        icon = "cog", 
        iconColor = "#f4f812ff", 
        models = {
            {model = "airbus", name = "Airport Bus"},
            {model = "bus", name = "Bus"},
            {model = "coach", name = "Coach"},
            {model = "pbus", name = "Party Bus"},
            {model = "rallytruck", name = "Rally Truck"},
            {model = "rentalbus", name = "Rental Shuttle Bus"},
            {model = "taxi", name = "Vapid Stanier Taxi"},
            {model = "tourbus", name = "Tour Bus"},
        }
    },
    {
        category = "Trailer", 
        icon = "trailer", 
        iconColor = "#ffffffff", 
        models = {
            {model = "armytrailer", name = "Army Trailer"},
            {model = "freighttrailer", name = "Freight Trailer"},
            {model = "armytanker", name = "Army Tanker"},
            {model = "trailerlarger", name = "MOC"},
            {model = "docktrailer", name = "Container Trailer"},
            {model = "tr3", name = "Large Boat Trailer"},
            {model = "tr2", name = "Car Trailer"},
            {model = "tr3", name = "Army Trailer"},
            {model = "trflat", name = "Flatbed Trailer"},
            {model = "trailers", name = "Countainer Trailer 2"},
            {model = "trailers4", name = "Countainer Trailer 3"},
            {model = "trailers2", name = "Trailer 2"},
            {model = "trailers3", name = "Trailer 3"},
            {model = "trailers5", name = "XMAS Trailer"},
            {model = "tvtrailer", name = "TV Trailer"},
            {model = "tvtrailer2", name = "TV Trailer 2"},
            {model = "trailerlogs", name = "Log Trailer"},
            {model = "tanker", name = "Fuel Tanker"},
            {model = "baletrailer", name = "Bale Trailer"},
            {model = "graintrailer", name = "Grain Trailer"},
            {model = "raketrailer", name = "Tractor Rake Trailer"},
            {model = "trailersmall", name = "Small Trailer"},
        }
    },
    {
        category = "Motorcycles", 
        icon = "motorcycle", 
        iconColor = "#FF6347", 
        models = {
            {model = "akuma", name = "Akuma"},
            {model = "avarus", name = "Avarus"},
            {model = "bagger", name = "Bagger"},
            {model = "bati", name = "Bati 801"},
            {model = "bati2", name = "Bati 801RR"},
            {model = "bf400", name = "BF400"},
            {model = "carbonrs", name = "Carbon RS"},
            {model = "chimera", name = "Chimera"},
            {model = "cliffhanger", name = "Cliffhanger"},
            {model = "daemon", name = "Daemon"},
            {model = "daemon2", name = "Daemon Custom"},
            {model = "defiler", name = "Defiler"},
            {model = "diablous", name = "Diabolus"},
            {model = "diablous2", name = "Diabolus Custom"},
            {model = "double", name = "Double T"},
            {model = "enduro", name = "Enduro"},
            {model = "esskey", name = "Esskey"},
            {model = "faggio", name = "Faggio"},
            {model = "faggio2", name = "Faggio Sport"},
            {model = "faggio3", name = "Faggio Mod"},
            {model = "gargoyle", name = "Gargoyle"},
            {model = "hakuchou", name = "Hakuchou"},
            {model = "hakuchou2", name = "Hakuchou Drag"},
            {model = "hexer", name = "Hexer"},
            {model = "innovation", name = "Innovation"},
            {model = "lectro", name = "Lectro"},
            {model = "manchez", name = "Manchez"},
            {model = "nemesis", name = "Nemesis"},
            {model = "nightblade", name = "Nightblade"},
            {model = "pcj", name = "PCJ 600"},
            {model = "ratbike", name = "Rat Bike"},
            {model = "ruffian", name = "Ruffian"},
            {model = "sanchez", name = "Sanchez"},
            {model = "sanchez2", name = "Sanchez (Livery)"},
            {model = "sanctus", name = "Sanctus"},
            {model = "shotaro", name = "Shotaro"},
            {model = "sovereign", name = "Sovereign"},
            {model = "thrust", name = "Thrust"},
            {model = "vader", name = "Vader"},
            {model = "vindicator", name = "Vindicator"},
            {model = "vortex", name = "Vortex"},
            {model = "wolfsbane", name = "Wolfsbane"},
            {model = "zombiea", name = "Zombie Bobber"},
            {model = "zombieb", name = "Zombie Chopper"}
        }
    },
    {
        category = "Open Wheel", 
        icon = "flag-checkered", 
        iconColor = "#51e623ff", 
        models = {
            {model = "formula", name = "PR4"},
            {model = "formula2", name = "R88"},
            {model = "openwheel1", name = "BR8"},
            {model = "openwheel2", name = "DR1"},
        }
    },
    {
        category = "Bicycle's", 
        icon = "bicycle", 
        iconColor = "#ffffffff", 
        models = {
            {model = "bmx", name = "BMX"},
            {model = "cruiser", name = "Cruiser"},
            {model = "fixter", name = "Fixter"},
            {model = "inductor", name = "Inductor"},
            {model = "inductor2", name = "Junk Energy Inductor"},
            {model = "scorcher", name = "Scorcher"},
            {model = "tribike", name = "Whippet Race Bike"},
            {model = "tribike2", name = "Endurex Race Bike"},
            {model = "tribike3", name = "Tri-Cycles Race Bike"},
        }
    },
    {
        category = "Helicopters", 
        icon = "helicopter", 
        iconColor = "#0066ffff", 
        models = {
            {model = "akula", name = "Akula"},
            {model = "annihilator", name = "Annihilator"},
            {model = "annihilator2", name = "Annihilator Stealth"},
            {model = "buzzard", name = "Buzzard Attack Chopper"},
            {model = "buzzard2", name = "Buzzard"},
            {model = "cargobob", name = "Cargobob"},
            {model = "cargobob2", name = "Cargobob Jetsam"},
            {model = "cargobob3", name = "Cargobob TPE"},
            {model = "conada", name = "Conada"},
            {model = "condada2", name = "Weaponized Conada"},
            {model = "frogger", name = "Frogger"},
            {model = "havok", name = "Havok"},
            {model = "hunter", name = "FH-1 Hunter"},
            {model = "maverick", name = "Maverick"},
            {model = "polmav", name = "Police/EMS Maverick"},
            {model = "seasparrow", name = "Sea Sparrow"},
            {model = "seasparrow2", name = "Sparrow"},
            {model = "skylift", name = "Skylift"},
            {model = "supervolito", name = "SuperVolito"},
            {model = "supervolito2", name = "SuperVolito Carbon"},
            {model = "swift", name = "Swift"},
            {model = "swift2", name = "Swift Deluxe"},
            {model = "valkyrie", name = "Valkyrie"},
            {model = "volatus", name = "Volatus"},
        }
    },
    {
        category = "Planes", 
        icon = "plane", 
        iconColor = "#0066ffff", 
        models = {
            {model = "alkonost", name = "RO-86 Alkonost"},
            {model = "alphaz1", name = "Alpha-Z1"},
            {model = "avenger", name = "Avenger"},
            {model = "besra", name = "Besra"},
            {model = "blimp", name = "Atomic Blimp"},
            {model = "blimp2", name = "Xero Blimp"},
            {model = "blimp3", name = "Custom Blimp"},
            {model = "bombushka", name = "RM-10 Bombushka"},
            {model = "cargoplane", name = "Cargo Plane"},
            {model = "cuban800", name = "Cuban 800"},
            {model = "dodo", name = "Dodo"},
            {model = "duster", name = "Crop Duster"},
            {model = "howard", name = "Howard NX-25"},
            {model = "hydra", name = "Hydra"},
            {model = "jet", name = "Commercial Jet"},
            {model = "lazer", name = "P-996 Lazer"},
            {model = "luxor", name = "Luxor"},
            {model = "luxor2", name = "Luxor Deluxe"},
            {model = "mammatus", name = "Mammatus"},
            {model = "microlight", name = "Ultralight"},
            {model = "miljet", name = "Military Jet"},
            {model = "mogul", name = "Mogul"},
            {model = "molotok", name = "V-65 Molotok"},
            {model = "nimbus", name = "Nimbus"},
            {model = "nokota", name = "P-45 Nokota"},
            {model = "pyro", name = "Pyro"},
            {model = "raiju", name = "F-160 Raiju"},
            {model = "rogue", name = "Rogue"},
            {model = "seabreeze", name = "Seabreeze"},
            {model = "shamal", name = "Shamal"},
            {model = "starling", name = "LF-22 Starling"},
            {model = "streamer216", name = "Streamer 216"},
            {model = "strikeforce", name = "B-11 Strikeforce"},
            {model = "stunt", name = "Mallard"},
            {model = "titan", name = "Titan"},
            {model = "tula", name = "Tula"},
            {model = "velum", name = "Velum"},
            {model = "velum2", name = "Velum (5-Seater)"},
            {model = "vestra", name = "Vestra"},
            {model = "volatol", name = "Volatol"},
        }
    },
    {
        category = "Other", 
        icon = "circle", 
        iconColor = "#ffffffff", 
        models = {
            {model = "airtug", name = "Airtug"},
            {model = "caddy", name = "Golf Cart"},
            {model = "caddy2", name = "Golf Cart Old"},
            {model = "caddy3", name = "Caddy Long"},
            {model = "forklift", name = "Forklift"},
            {model = "mower", name = "Lawn Mower"},
            {model = "ripley", name = "Ripley"},
            {model = "tractor", name = "Tractor"},
            {model = "bulldozer", name = "Bulldozer"},
            {model = "cutter", name = "Cutter"},
            {model = "dump", name = "Dump Truck"},
            {model = "wastelander", name = "Wastelander"},
        }
    },
}

-- Emergency vehicles with subcategories
local emergencyVehicles = {
    {
        subcategory = "Blaine County Sheriffs Office",
        icon = "shield-halved",
        vehicles = {
            {model = "socharger2", name = "BCSO 2023 Dodge Charger"},
            {model = "socharger", name = "BCSO 2014 Dodge Charger"},
            {model = "sodurango", name = "BCSO 2022 Dodge Durango"},
            {model = "sofpiu", name = "BCSO 2021 Ford FPIU"},
            {model = "sotruck", name = "BCSO 2018 Ford F-150"},
            {model = "sotaurus", name = "BCSO 2018 Ford Taurus"},
            {model = "sotahoe", name = "BCSO 2024 Chevy Tahoe"}
        }
    },
    {
        subcategory = "Los Santos Police Department",
        icon = "shield-halved",
        vehicles = {
            {model = "segway", name = "LSPD Segway"},
            {model = "rav4hyb", name = "LSPD Detective 2024 Toyota Rav4"},
            {model = "25umfpiu", name = "LSPD Detective 2025 Ford Explorer"},
            {model = "umdet1", name = "LSPD Detective 2022 Dodge Durango"},
            {model = "pdfpiu", name = "LSPD 2023 Ford FPIU"},
            {model = "pdbike", name = "LSPD 2016 BMW R1200RT"},
            {model = "pdcvpi", name = "LSPD 2011 Ford CVPI"},
            {model = "pdtaurus", name = "LSPD 2018 Ford Taurus"},
            {model = "pdcharger", name = "LSPD 2021 Dodge Charger"},
            {model = "pdimpala", name = "LSPD 2011 Chevy Impala"},
            {model = "pdcaprice", name = "LSPD 2013 Chevy Caprice"},
            {model = "pdtahoe", name = "LSPD 2021 Chevy Tahoe"},
            {model = "pdtruck", name = "LSPD 2023 Chevy Silverado"}
        }
    },
    {
        subcategory = "San Andreas Highway Patrol",
        icon = "shield-halved",
        vehicles = {
            {model = "hpcharger", name = "SAHP 2022 Dodge Charger"}
        }
    },
    {
        subcategory = "San Andreas Fire Rescue",
        icon = "fire-extinguisher",
        vehicles = {
            {model = "fordambo", name = "SAFR Ford F-250 Ambulance"}
        }
    }
}

-- Addon vehicles with subcategories
local addonVehicles = {
    {
        subcategory = "Compacts",
        icon = "car",
        vehicles = {
            {model = "piccolo", name = "Grotti Piccolo"},
            {model = "twingo", name = "Renault Twingo"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Sedans",
        icon = "car",
        vehicles = {
            {model = "golf8gti", name = "VW Golf 8 GTI"},
            {model = "golfgti7", name = "VW Golf 7 GTI"},
            {model = "tltypes", name = "Honda Acura TLS"},
            {model = "teslapd", name = "Tesla Model S"},
            {model = "tmodel", name = "Tesla Model 3"},
            {model = "c6320", name = "Mercedes AMG C63S"},
            {model = "77monaco", name = "1977 Dodge Monaco "},
            {model = "22char", name = "2022 Dodge Charger"},
            {model = "08char", name = "2008 Dodge Charger"},
            {model = "impa6", name = "2006 Chevy Impala LS"},
            {model = "22530i", name = "2022 BMW 530I Wagon"},
            {model = "22ct4", name = "2022 Cadillac Ct4"},
            {model = "13malibu", name = "2023 Chevy Malibu"},
            {model = "03impa", name = "2003 Chevy Impala"},
            {model = "cmr11", name = "2011 Toyota Camry"},
            {model = "vic11", name = "2011 Ford Crown Victoria"},
            {model = "11cvpiciv", name = "2011 Ford CVPI (Retired)"},
            {model = "18chargerciv", name = "2018 Dodge Charger PPV (Retired)"},
            {model = "m3e36", name = "BMW M3 E36"},
            {model = "22rs5", name = "2022 Audi rs5"},
            {model = "22m5sal", name = "2022 BMW M5"},
            {model = "m422", name = "2022 BMW M4"},
            {model = "21avant", name = "2021 Audi RS5 Avant"},
            {model = "nbmazda3", name = "2020 Mazda 3"},
            {model = "saab93aeroc", name = "Saab 93"},
            {model = "rbmwm3f80", name = "BMW M3 F80"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Sports",
        icon = "flag-checkered",
        vehicles = {
            {model = "22m5", name = "2022 BMW M5 CS"},
            {model = "22bengt", name = "2022 Bentley GT Continental"},
            {model = "mustang68", name = "1968 Ford Mustang"},
            {model = "nbbatur", name = "Bentley Batur"},
            {model = "ypg205t16a", name = "Peugeot 205 (Rally)"},
            {model = "ypg205t16b", name = "Peugeot 205"},
            {model = "majfd", name = "Mazda RX-7"},
            {model = "99viper", name = "1999 Dodge Viper"},
            {model = "cam8tun", name = "Toyota Camry XSE"},
            {model = "z32", name = "Fairlady Z 300ZX"},
            {model = "ap2", name = "Honda S2000"},
            {model = "focusrs", name = "2017 Ford Focus RS"},
            {model = "s63w222", name = "Mercedes AMG S63"},
            {model = "rufrgt8", name = "Porshe GT8"},
            {model = "24mustdh", name = "2024 Ford Mustang GT"},
            {model = "cali57", name = "Ferrari 250 GT"},
            {model = "20gt500", name = "2020 Ford Mustang GT"},
            {model = "59coronet", name = "1959 Dodge Coronet"},
            {model = "chrysler11", name = "Chrysler"},
            {model = "21ltz", name = "2021 Chevy Camero ZL1"},
            {model = "20gt500", name = "2020 Ford Mustang GT"},
            {model = "gtr50", name = "Nissan GT-R50"},
            {model = "r820", name = "Audi R8"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Super",
        icon = "gauge-high",
        vehicles = {
            {model = "mig", name = "Ferrari"},
            {model = "jeskoattack24", name = "Koenigsegg Jesko"},
            {model = "f812", name = "Ferrari F812"},
            {model = "italigtb2", name = "Ferrari Itali GTB"},
            {model = "f4090", name = "Ferrari F4090"},
            {model = "czr1", name = "Chevy Corvette ZR"},
            {model = "c7", name = "Chevy Corvette C7"},
            {model = "evija", name = "2020 Lotus Evija"},
            {model = "20gt500", name = "2020 Ford Mustang GT"},
            {model = "bolide", name = "2020 Bugatti Bolide"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "SUVs",
        icon = "truck",
        vehicles = {
            {model = "teslax", name = "Tesla Model X"},
            {model = "mache", name = "Ford MachE"},
            {model = "4runner", name = "Toyota 4 Runner"},
            {model = "g63sec20", name = "Mercedes AMG G63"},
            {model = "urus", name = "Lamborghini Urus"},
            {model = "bbentayga", name = "Bentley Bentayga"},
            {model = "vxr", name = "Toyota VXR V8"},
            {model = "16i3", name = "2016 BMW I3"},
            {model = "tundra2021", name = "2021 Toyota Tundra"},
            {model = "expmax20", name = "2020 Ford Expedition Platinum"},
            {model = "22exp", name = "2022 Ford Expedition"},
            {model = "21dura", name = "2021 Dodge Durango Citreol"},
            {model = "19exp", name = "2019 Ford Explorer"},
            {model = "15expxl", name = "2015 Ford Expedition"},
            {model = "15exp", name = "2015 Ford Expedition Platinum"},
            {model = "02tahoe", name = "2002 Chevy Tahoe"},
            {model = "ncavalcade", name = "Cavalcade"},
            {model = "20tahoeciv", name = "2018 Chevy Tahoe (Retired)"},
            {model = "16fpiuciv", name = "2016 Ford FPIU (Retired)"},
            {model = "sec_rav424", name = "2021 Toyota Rav4 Hybrid"},
            {model = "tahoe08", name = "2008 Chevy Tahoe"},
            {model = "21subur", name = "2021 Chevy Suburban"},
            {model = "15carv", name = "2015 Dodge Grand Caravan"},
            {model = "sec_rav424", name = "2021 Toyota Rav4 Hybrid"},
            {model = "sec_rav424", name = "2021 Toyota Rav4 Hybrid"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Off-Road",
        icon = "mountain",
        vehicles = {
            {model = "peacemaker", name = "Gallavanter Peacemaker"},
            {model = "peacemaker4", name = "Gallavanter Peacemaker (Bed)"},
            {model = "peacemaker6", name = "Gallavanter Peacemaker (Net)"},
            {model = "f150", name = "2015 Ford F-150 SVT"},
            {model = "f150army", name = "2015 Ford F-150 (Army)"},
            {model = "rubicon24", name = "2024 Jeep Rubicon"},
            {model = "nsandstorm3", name = "Vapid Sandstorm (Single Cab)"},
            {model = "nsandstorm2", name = "Vapid Sandstorm (Dually)"},
            {model = "nsandstorm", name = "Vapid Sandstorm (Crew Cab)"},
            {model = "hellenstorm", name = "Vapid Hellenstorm"},
            {model = "CyberTruckV", name = "Tesla Cybertruck"},
            {model = "wildtrak", name = "Ford Bronco Wildtrack"},
            {model = "velociraptor", name = "Ford F-150 Velociraptor"},
            {model = "f35019", name = "2019 Ford F-350"},
            {model = "22mavxl", name = "2022 Ford Maverick"},
            {model = "22f450xl", name = "2022 Ford F450 XL Superduty"},
            {model = "22f450xl", name = "2022 Ford F450 Limited Superduty"},
            {model = "21f250", name = "2021 Ford F-250 Superduty"},
            {model = "21f150", name = "2021 Ford F-150"},
            {model = "21brooff", name = "2021 Ford Bronco Sport"},
            {model = "21bro", name = "2021 Ford Bronco"},
            {model = "18raptor", name = "2018 Ford F-150 Raptor"},
            {model = "22silvwt", name = "2021 Chevy Silverado"},
            {model = "22silvltz", name = "2021 Chevy Silverado LTZ"},
            {model = "21f150", name = "2021 Ford F-150"},
            {model = "cararv", name = "Vapid Caracara 4x4 RV"},
            {model = "sandkingRV", name = "Vapid Sandking RV"},
            {model = "guardianrv", name = "Vapid Guardian RV"},
            {model = "sandroamer", name = "Vapid Sandroamer RV"},
            {model = "f15078", name = "1978 Ford F-150"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Vans",
        icon = "van-shuttle",
        vehicles = {
            {model = "22chevango", name = "2012 Chevy Express (Cargo)"},
            {model = "22chevan", name = "2012 Chevy Express (Passenger)"},
            {model = "jogger", name = "Benefactor Jogger"},
            {model = "joggerpas", name = "Benefactor Jogger (Passenger)"},
            {model = "imperialev", name = "Benefactor Imperial EV"},
            {model = "imperialpas", name = "Benefactor Imperial (Passenger)"},
            {model = "imperial", name = "Benefactor Imperial"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Motorcycles",
        icon = "motorcycle",
        vehicles = {
            {model = "21z900", name = "Kawasaki Z900"},
            {model = "g_xlcr", name = "Harley Davidson Sportser"},
            {model = "r1200gsec", name = "BMW R1200"},
            {model = "pcx160_2025", name = "PCX 160"},
            {model = "ip_m1000rr_23", name = "BMW M1000RR"},
            {model = "s1000sec", name = "BMW S1000R"},
            {model = "goldwing", name = "Honda Goldwing"},
            {model = "sahara300", name = "Sahara 300"},
            {model = "117", name = "Harley Davidson Bike"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Utility",
        icon = "circle",
        vehicles = {
            {model = "segwayciv", name = "Segway"},
            {model = "iak_wheelchair", name = "Wheelchair"},
            {model = "galaxyroamer", name = "Galaxy Roamer Bus RV"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Boats",
        icon = "circle",
        vehicles = {
            {model = "amels200", name = "AMELS200"},
            {model = "650e", name = "Sea Ray 650E"},
            -- Add your addon vehicles here
        }
    },
}

local function SpawnVehicle(model, savedData, keepMenuOpen, menuCallback)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local currentVehicle = GetVehiclePedIsIn(ped, false)
    
    if replaceVehicle and currentVehicle ~= 0 then
        SetEntityAsMissionEntity(currentVehicle, true, true)
        DeleteEntity(currentVehicle)
    end
    
    local hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end
    
    local spawnCoords = coords
    local groundFound, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)
    if groundFound then
        spawnCoords = vector3(coords.x, coords.y, groundZ + 1.0)
    end
    
    local vehicle = CreateVehicle(hash, spawnCoords.x, spawnCoords.y, spawnCoords.z, heading, true, false)
    SetVehicleOnGroundProperly(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetModelAsNoLongerNeeded(hash)
    SetVehRadioStation(vehicle, 'OFF')
    
    if savedData then
        SetVehicleModKit(vehicle, 0)
        if savedData.colors then
            SetVehicleColours(vehicle, savedData.colors.primary, savedData.colors.secondary)
        end
        if savedData.livery then
            SetVehicleLivery(vehicle, savedData.livery)
        end
        if savedData.plate then
            SetVehicleNumberPlateText(vehicle, savedData.plate)
        end
        if savedData.plateIndex then
            SetVehicleNumberPlateTextIndex(vehicle, savedData.plateIndex)
        end
        if savedData.mods then
            for modType, modValue in pairs(savedData.mods) do
                SetVehicleMod(vehicle, tonumber(modType), modValue, false)
            end
        end
        if savedData.windowTint then
            SetVehicleWindowTint(vehicle, savedData.windowTint)
        end
        if savedData.turbo then
            ToggleVehicleMod(vehicle, 18, true)
        end
        if savedData.extras then
            for extraId, state in pairs(savedData.extras) do
                SetVehicleExtra(vehicle, tonumber(extraId), state and 0 or 1)
            end
        end
    end
    
    TaskWarpPedIntoVehicle(ped, vehicle, -1)
    lib.notify({title = 'Vehicle Spawned', description = model:upper(), type = 'success'})
    
    if keepMenuOpen and menuCallback then
        menuCallback()
    end
end

-- Thread to manage no helmet
CreateThread(function()
    while true do
        Wait(0)
        if noHelmet then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                SetPedConfigFlag(ped, 35, false)
            end
        end
    end
end)

-- Thread to manage always clean vehicle
CreateThread(function()
    while true do
        Wait(1000)
        if alwaysClean then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            if vehicle ~= 0 then
                local dirtLevel = GetVehicleDirtLevel(vehicle)
                if dirtLevel > 0 then
                    SetVehicleDirtLevel(vehicle, 0.0)
                end
            end
        end
    end
end)

local function SaveCurrentVehicle()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local categoryOptions = {
        {value = 'personal', label = 'Personal'},
        {value = 'work', label = 'Work'},
        {value = 'emergency', label = 'Emergency'},
        {value = 'favorites', label = 'Favorites'}
    }
    
    local input = lib.inputDialog('Save Vehicle', {
        {type = 'input', label = 'Vehicle Name', required = true, min = 1, max = 30},
        {type = 'select', label = 'Category', options = categoryOptions, required = true, default = 'personal'}
    })
    
    if not input then return end
    
    local model = GetEntityModel(vehicle)
    local modelName = GetDisplayNameFromVehicleModel(model):lower()
    
    local vehicleData = {
        model = modelName,
        category = input[2],
        colors = {
            primary = select(1, GetVehicleColours(vehicle)),
            secondary = select(2, GetVehicleColours(vehicle))
        },
        livery = GetVehicleLivery(vehicle),
        plate = GetVehicleNumberPlateText(vehicle),
        plateIndex = GetVehicleNumberPlateTextIndex(vehicle),
        mods = {},
        windowTint = GetVehicleWindowTint(vehicle),
        turbo = IsToggleModOn(vehicle, 18),
        extras = {}
    }
    
    SetVehicleModKit(vehicle, 0)
    for i = 0, 49 do
        local modValue = GetVehicleMod(vehicle, i)
        if modValue ~= -1 then
            vehicleData.mods[tostring(i)] = modValue
        end
    end
    
    for i = 0, 14 do
        if DoesExtraExist(vehicle, i) then
            vehicleData.extras[tostring(i)] = IsVehicleExtraTurnedOn(vehicle, i)
        end
    end
    
    table.insert(savedVehicles, {name = input[1], data = vehicleData})
    SaveVehiclesToKVP()
    
    lib.notify({title = 'Vehicle Saved', description = input[1], type = 'success'})
    openSavedVehiclesMenu()
end

local function openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
    local saved = savedVehicles[vehicleIndex]
    
    lib.registerMenu({
        id = 'saved_vehicle_options_menu',
        title = saved.name,
        position = 'top-right',
        onClose = function()
            openCategoryVehiclesMenu(categoryId, categoryName)
        end,
        options = {
            {
                label = 'Spawn Vehicle',
                description = 'Spawn ' .. saved.name,
                icon = 'car',
                iconColor = '#00ff00'
            },
            {
                label = 'Replace with Current',
                description = 'Update saved vehicle data',
                icon = 'rotate',
                iconColor = '#1E90FF'
            },
            {
                label = 'Change Category',
                description = 'Current: ' .. saved.data.category,
                icon = 'folder',
                iconColor = '#FFA500'
            },
            {
                label = 'Delete Vehicle',
                description = 'Cannot be undone',
                icon = 'trash',
                iconColor = '#ff0000'
            },
            {
                label = '← Back',
                description = 'Return to category',
                icon = 'arrow-left',
                iconColor = '#95a5a6'
            }
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            SpawnVehicle(saved.data.model, saved.data, true, function()
                openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
            end)
        elseif selected == 2 then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            
            if vehicle == 0 then
                lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
                openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
                return
            end
            
            local alert = lib.alertDialog({
                header = 'Replace Vehicle?',
                content = 'Replace "' .. savedVehicles[vehicleIndex].name .. '" with current vehicle?',
                centered = true,
                cancel = true
            })
            
            if alert == 'confirm' then
                local model = GetEntityModel(vehicle)
                local modelName = GetDisplayNameFromVehicleModel(model):lower()
                
                local vehicleData = {
                    model = modelName,
                    category = savedVehicles[vehicleIndex].data.category,
                    colors = {
                        primary = select(1, GetVehicleColours(vehicle)),
                        secondary = select(2, GetVehicleColours(vehicle))
                    },
                    livery = GetVehicleLivery(vehicle),
                    plate = GetVehicleNumberPlateText(vehicle),
                    plateIndex = GetVehicleNumberPlateTextIndex(vehicle),
                    mods = {},
                    windowTint = GetVehicleWindowTint(vehicle),
                    turbo = IsToggleModOn(vehicle, 18),
                    extras = {}
                }
                
                SetVehicleModKit(vehicle, 0)
                for i = 0, 49 do
                    local modValue = GetVehicleMod(vehicle, i)
                    if modValue ~= -1 then
                        vehicleData.mods[tostring(i)] = modValue
                    end
                end
                
                for i = 0, 14 do
                    if DoesExtraExist(vehicle, i) then
                        vehicleData.extras[tostring(i)] = IsVehicleExtraTurnedOn(vehicle, i)
                    end
                end
                
                savedVehicles[vehicleIndex].data = vehicleData
                SaveVehiclesToKVP()
                
                lib.notify({title = 'Vehicle Replaced', description = savedVehicles[vehicleIndex].name, type = 'success'})
                openCategoryVehiclesMenu(categoryId, categoryName)
            else
                openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
            end
        elseif selected == 3 then
            local categoryOptions = {
                {value = 'personal', label = 'Personal'},
                {value = 'work', label = 'Work'},
                {value = 'racing', label = 'Racing'},
                {value = 'offroad', label = 'Off-Road'},
                {value = 'luxury', label = 'Luxury'},
                {value = 'emergency', label = 'Emergency'},
                {value = 'utility', label = 'Utility'},
                {value = 'custom', label = 'Custom'},
                {value = 'favorites', label = 'Favorites'},
                {value = 'other', label = 'Other'}
            }
            
            local input = lib.inputDialog('Change Category', {
                {type = 'select', label = 'New Category', options = categoryOptions, required = true, default = savedVehicles[vehicleIndex].data.category}
            })
            
            if input then
                savedVehicles[vehicleIndex].data.category = input[1]
                SaveVehiclesToKVP()
                lib.notify({title = 'Category Updated', description = 'Changed to ' .. input[1], type = 'success'})
                openCategoryVehiclesMenu(categoryId, categoryName)
            else
                openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
            end
        elseif selected == 4 then
            local alert = lib.alertDialog({
                header = 'Delete Vehicle?',
                content = 'Delete "' .. saved.name .. '"?',
                centered = true,
                cancel = true
            })
            
            if alert == 'confirm' then
                table.remove(savedVehicles, vehicleIndex)
                SaveVehiclesToKVP()
                lib.notify({title = 'Vehicle Deleted', description = saved.name, type = 'success'})
                openCategoryVehiclesMenu(categoryId, categoryName)
            else
                openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
            end
        elseif selected == 5 then
            openCategoryVehiclesMenu(categoryId, categoryName)
        end
    end)
    
    lib.showMenu('saved_vehicle_options_menu')
end

function openCategoryVehiclesMenu(categoryId, categoryName)
    local options = {}
    local categoryVehicles = {}
    
    if categoryId == 'all' then
        categoryVehicles = savedVehicles
    else
        for _, saved in ipairs(savedVehicles) do
            if saved.data.category == categoryId then
                table.insert(categoryVehicles, saved)
            end
        end
    end
    
    if #categoryVehicles == 0 then
        table.insert(options, {
            label = 'No Vehicles',
            description = 'No vehicles in this category',
            icon = 'circle-xmark',
            iconColor = '#ff0000'
        })
    else
        for i, saved in ipairs(categoryVehicles) do
            local actualIndex = 0
            for j, v in ipairs(savedVehicles) do
                if v.name == saved.name and v.data.model == saved.data.model then
                    actualIndex = j
                    break
                end
            end
            
            table.insert(options, {
                label = saved.name,
                description = saved.data.model:upper() .. ' • ' .. saved.data.category,
                icon = 'car',
                iconColor = '#00BFFF',
                args = {index = actualIndex}
            })
        end
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to saved vehicles',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'category_vehicles_menu',
        title = categoryName,
        position = 'top-right',
        onClose = function()
            openSavedVehiclesMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openSavedVehiclesMenu()
        elseif options[selected].args and options[selected].args.index then
            openSavedVehicleOptionsMenu(options[selected].args.index, categoryId, categoryName)
        end
    end)
    
    lib.showMenu('category_vehicles_menu')
end

function openSavedVehiclesMenu()
    local categories = {
        {id = 'all', name = 'All Vehicles', icon = 'list'},
        {id = 'personal', name = 'Personal', icon = 'user'},
        {id = 'work', name = 'Work', icon = 'briefcase'},
        {id = 'emergency', name = 'Emergency', icon = 'shield-halved'},
        {id = 'favorites', name = 'Favorites', icon = 'heart'}
    }
    
    local options = {
        {
            label = 'Save Current Vehicle',
            description = 'Save your current vehicle',
            icon = 'floppy-disk',
            iconColor = '#00ff00'
        }
    }
    
    for _, cat in ipairs(categories) do
        local count = 0
        if cat.id == 'all' then
            count = #savedVehicles
        else
            for _, saved in ipairs(savedVehicles) do
                if saved.data.category == cat.id then
                    count = count + 1
                end
            end
        end
        
        table.insert(options, {
            label = cat.name,
            description = count .. ' vehicle(s)',
            icon = cat.icon,
            iconColor = '#4169E1',
            args = {id = cat.id, name = cat.name}
        })
    end
    
    if #savedVehicles > 0 then
        table.insert(options, {
            label = 'Delete All',
            description = 'Delete all saved vehicles',
            icon = 'trash',
            iconColor = '#ff0000'
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to vehicle menu',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'saved_vehicles_menu',
        title = 'Saved Vehicles',
        position = 'top-right',
        onClose = function()
            openVehicleMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            SaveCurrentVehicle()
        elseif selected == #options then
            openVehicleMenu()
        elseif selected == #options - 1 and #savedVehicles > 0 then
            local alert = lib.alertDialog({
                header = 'Delete All?',
                content = 'Cannot be undone',
                centered = true,
                cancel = true
            })
            
            if alert == 'confirm' then
                savedVehicles = {}
                SaveVehiclesToKVP()
                lib.notify({title = 'Cleared', type = 'success'})
                openSavedVehiclesMenu()
            else
                openSavedVehiclesMenu()
            end
        elseif options[selected].args then
            openCategoryVehiclesMenu(options[selected].args.id, options[selected].args.name)
        end
    end)
    
    lib.showMenu('saved_vehicles_menu')
end

function openEmergencySubcategoryMenu(subcategory)
    local options = {}
    
    for _, vehicle in ipairs(subcategory.vehicles) do
        table.insert(options, {
            label = vehicle.name,
            description = vehicle.model:upper(),
            icon = 'car-side',
            iconColor = '#FF0000',
            args = {model = vehicle.model}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to emergency vehicles',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'emergency_subcategory_menu',
        title = subcategory.subcategory,
        position = 'top-right',
        onClose = function()
            openEmergencyMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openEmergencyMenu()
        else
            SpawnVehicle(options[selected].args.model, nil, true, function()
                openEmergencySubcategoryMenu(subcategory)
            end)
        end
    end)
    
    lib.showMenu('emergency_subcategory_menu')
end

function openEmergencyMenu()
    local options = {}
    
    for i, subcategory in ipairs(emergencyVehicles) do
        table.insert(options, {
            label = subcategory.subcategory,
            description = #subcategory.vehicles .. ' vehicles',
            icon = subcategory.icon,
            iconColor = '#FF0000',
            args = {index = i}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to vehicle spawner',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'emergency_main_menu',
        title = 'Emergency Vehicles',
        position = 'top-right',
        onClose = function()
            openVehicleSpawnerMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openVehicleSpawnerMenu()
        else
            openEmergencySubcategoryMenu(emergencyVehicles[options[selected].args.index])
        end
    end)
    
    lib.showMenu('emergency_main_menu')
end

function openAddonSubcategoryMenu(subcategory)
    local options = {}
    
    for _, vehicle in ipairs(subcategory.vehicles) do
        table.insert(options, {
            label = vehicle.name,
            description = vehicle.model:upper(),
            icon = 'car-side',
            iconColor = '#FFD700',
            args = {model = vehicle.model}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to addon vehicles',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'addon_subcategory_menu',
        title = subcategory.subcategory,
        position = 'top-right',
        onClose = function()
            openAddonMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openAddonMenu()
        else
            SpawnVehicle(options[selected].args.model, nil, true, function()
                openAddonSubcategoryMenu(subcategory)
            end)
        end
    end)
    
    lib.showMenu('addon_subcategory_menu')
end

function openAddonMenu()
    local options = {}
    
    for i, subcategory in ipairs(addonVehicles) do
        table.insert(options, {
            label = subcategory.subcategory,
            description = #subcategory.vehicles .. ' vehicles',
            icon = subcategory.icon,
            iconColor = '#FFD700',
            args = {index = i}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to vehicle spawner',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'addon_main_menu',
        title = 'Addon Vehicles',
        position = 'top-right',
        onClose = function()
            openVehicleSpawnerMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openVehicleSpawnerMenu()
        else
            openAddonSubcategoryMenu(addonVehicles[options[selected].args.index])
        end
    end)
    
    lib.showMenu('addon_main_menu')
end

function openCategoryMenu(category)
    local options = {}
    
    for _, vehicle in ipairs(category.models) do
        table.insert(options, {
            label = vehicle.name,
            description = vehicle.model and vehicle.model:upper() or "Unknown",
            icon = 'car-side',
            iconColor = category.iconColor,
            args = {model = vehicle.model}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to vehicle spawner',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'vehicle_category_menu',
        title = category.category .. ' Vehicles',
        position = 'top-right',
        onClose = function()
            openVehicleSpawnerMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openVehicleSpawnerMenu()
        else
            SpawnVehicle(options[selected].args.model, nil, true, function()
                openCategoryMenu(category)
            end)
        end
    end)
    
    lib.showMenu('vehicle_category_menu')
end

function openVehicleSpawnerMenu()
    local options = {
        {
            label = replaceVehicle and 'Replace Current Vehicle: ON' or 'Replace Current Vehicle: OFF',
            description = 'Toggle vehicle replacement',
            icon = replaceVehicle and 'toggle-on' or 'toggle-off',
            iconColor = replaceVehicle and '#00ff00' or '#ff0000'
        },
        {
            label = 'Custom Vehicles',
            description = 'Custom addon vehicles',
            icon = 'star',
            iconColor = '#FFD700',
            args = {type = 'addon'}
        },
        {
            label = 'Emergency',
            description = 'Emergency service vehicles',
            icon = 'shield-halved',
            iconColor = '#FF0000',
            args = {type = 'emergency'}
        }
    }
    
    for i, category in ipairs(vehicles) do
        table.insert(options, {
            label = category.category,
            description = #category.models .. ' vehicles',
            icon = category.icon,
            iconColor = category.iconColor,
            args = {type = 'category', index = i}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to vehicle menu',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'vehicle_spawner_menu',
        title = 'Vehicle Spawner',
        position = 'top-right',
        onClose = function()
            openVehicleMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            replaceVehicle = not replaceVehicle
            lib.notify({title = 'Setting Updated', type = 'info'})
            openVehicleSpawnerMenu()
        elseif selected == #options then
            openVehicleMenu()
        elseif options[selected].args then
            if options[selected].args.type == 'addon' then
                openAddonMenu()
            elseif options[selected].args.type == 'emergency' then
                openEmergencyMenu()
            elseif options[selected].args.type == 'category' then
                openCategoryMenu(vehicles[options[selected].args.index])
            end
        end
    end)
    
    lib.showMenu('vehicle_spawner_menu')
end

-- Vehicle Customization Functions
function openPrimaryColorMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local colors = {
        {name = 'Black', id = 0}, {name = 'Carbon Black', id = 147}, {name = 'Graphite', id = 1},
        {name = 'Steel', id = 3}, {name = 'Silver', id = 4}, {name = 'Frost White', id = 111},
        {name = 'Red', id = 27}, {name = 'Torino Red', id = 28}, {name = 'Formula Red', id = 29},
        {name = 'Blaze Red', id = 30}, {name = 'Hot Pink', id = 135}, {name = 'Orange', id = 38},
        {name = 'Yellow', id = 88}, {name = 'Dark Green', id = 49}, {name = 'Lime Green', id = 92},
        {name = 'Blue', id = 64}, {name = 'Light Blue', id = 74}, {name = 'Purple', id = 145}
    }
    
    local options = {}
    for _, color in ipairs(colors) do
        table.insert(options, {
            label = color.name,
            icon = 'circle',
            iconColor = '#' .. string.format("%06x", color.id),
            args = {colorId = color.id, colorName = color.name}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to customization',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'primary_color_menu',
        title = 'Primary Color',
        position = 'top-right',
        
        onClose = function()
            openVehicleCustomizationMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openVehicleCustomizationMenu()
        else
            local _, secondary = GetVehicleColours(vehicle)
            SetVehicleColours(vehicle, options[selected].args.colorId, secondary)
            lib.notify({title = 'Color Changed', description = options[selected].args.colorName, type = 'success'})
            openPrimaryColorMenu()
        end
    end)
    
    lib.showMenu('primary_color_menu')
end

function openSecondaryColorMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local colors = {
        {name = 'Black', id = 0}, {name = 'Carbon Black', id = 147}, {name = 'Graphite', id = 1},
        {name = 'Steel', id = 3}, {name = 'Silver', id = 4}, {name = 'Frost White', id = 111},
        {name = 'Red', id = 27}, {name = 'Torino Red', id = 28}, {name = 'Formula Red', id = 29},
        {name = 'Blaze Red', id = 30}, {name = 'Hot Pink', id = 135}, {name = 'Orange', id = 38},
        {name = 'Yellow', id = 88}, {name = 'Dark Green', id = 49}, {name = 'Lime Green', id = 92},
        {name = 'Blue', id = 64}, {name = 'Light Blue', id = 74}, {name = 'Purple', id = 145}
    }
    
    local options = {}
    for _, color in ipairs(colors) do
        table.insert(options, {
            label = color.name,
            icon = 'circle',
            iconColor = '#4169E1',
            args = {colorId = color.id, colorName = color.name}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to customization',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'secondary_color_menu',
        title = 'Secondary Color',
        position = 'top-right',
        
        onClose = function()
            openVehicleCustomizationMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openVehicleCustomizationMenu()
        else
            local primary, _ = GetVehicleColours(vehicle)
            SetVehicleColours(vehicle, primary, options[selected].args.colorId)
            lib.notify({title = 'Color Changed', description = options[selected].args.colorName, type = 'success'})
            openSecondaryColorMenu()
        end
    end)
    
    lib.showMenu('secondary_color_menu')
end

local function openLicensePlateMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local plateStyles = {
        {name = 'Blue on White 1', id = 0},
        {name = 'Yellow on Black', id = 1},
        {name = 'Yellow on Blue', id = 2},
        {name = 'Blue on White 2', id = 3},
        {name = 'Blue on White 3', id = 4},
        {name = 'Yankton', id = 5}
    }
    
    local options = {
        {
            label = 'Change Plate Text',
            description = 'Current: ' .. GetVehicleNumberPlateText(vehicle),
            icon = 'keyboard',
            iconColor = '#FFD700'
        }
    }
    
    local currentStyle = GetVehicleNumberPlateTextIndex(vehicle)
    for _, style in ipairs(plateStyles) do
        local isActive = currentStyle == style.id
        table.insert(options, {
            label = style.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'address-card',
            iconColor = isActive and '#00ff00' or '#4169E1',
            args = {styleId = style.id, styleName = style.name}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to customization',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'license_plate_menu',
        title = 'License Plate',
        position = 'top-right',
        onClose = function()
            openVehicleCustomizationMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            local input = lib.inputDialog('License Plate Text', {
                {type = 'input', label = 'Plate Text', placeholder = 'Max 8 characters', required = true, min = 1, max = 8, default = GetVehicleNumberPlateText(vehicle)}
            })
            
            if input then
                SetVehicleNumberPlateText(vehicle, input[1])
                lib.notify({title = 'Plate Changed', description = input[1], type = 'success'})
            end
            openLicensePlateMenu()
        elseif selected == #options then
            openVehicleCustomizationMenu()
        else
            SetVehicleNumberPlateTextIndex(vehicle, options[selected].args.styleId)
            lib.notify({title = 'Plate Style Changed', description = options[selected].args.styleName, type = 'success'})
            openLicensePlateMenu()
        end
    end)
    
    lib.showMenu('license_plate_menu')
end

-- Performance Mods Menu
function openPerformanceModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local performanceMods = {
        {modType = 11, name = 'Engine', icon = 'gears'},
        {modType = 12, name = 'Brakes', icon = 'circle-stop'},
        {modType = 13, name = 'Transmission', icon = 'gauge-high'},
        {modType = 15, name = 'Suspension', icon = 'car-side'},
        {modType = 16, name = 'Armor', icon = 'shield-halved'}
    }
    
    local options = {}
    
    -- Turbo option
    local hasTurbo = IsToggleModOn(vehicle, 18)
    table.insert(options, {
        label = 'Turbo',
        description = 'Status: ' .. (hasTurbo and 'ON' or 'OFF'),
        icon = 'wind',
        iconColor = hasTurbo and '#00ff00' or '#ff0000'
    })
    
    -- Performance mods
    for _, mod in ipairs(performanceMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                label = mod.name,
                description = 'Configure ' .. mod.name:lower() .. ' upgrades',
                icon = mod.icon,
                iconColor = '#1E90FF',
                args = {modType = mod.modType, modName = mod.name}
            })
        end
    end
    
    if #options == 1 then
        table.insert(options, {
            label = 'No Performance Mods Available',
            description = 'This vehicle has no performance mods',
            icon = 'circle-xmark',
            iconColor = '#ff0000'
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to customization',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'performance_mods_menu',
        title = 'Performance Upgrades',
        position = 'top-right',
        
        onClose = function()
            openVehicleCustomizationMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            ToggleVehicleMod(vehicle, 18, not hasTurbo)
            lib.notify({title = 'Turbo', description = hasTurbo and 'Disabled' or 'Enabled', type = 'success'})
            openPerformanceModsMenu()
        elseif selected == #options then
            openVehicleCustomizationMenu()
        elseif options[selected].args then
            openSpecificModMenu(options[selected].args.modType, options[selected].args.modName, 'performance_mods_menu')
        end
    end)
    
    lib.showMenu('performance_mods_menu')
end

-- Specific Mod Selection Menu
function openSpecificModMenu(modType, modName, parentMenu)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    local maxMod = GetNumVehicleMods(vehicle, modType)
    local currentMod = GetVehicleMod(vehicle, modType)
    
    local performanceLabels = {
        [11] = {'Stock Engine', 'Level 1 Engine', 'Level 2 Engine', 'Level 3 Engine', 'Level 4 Engine'},
        [12] = {'Stock Brakes', 'Street Brakes', 'Sport Brakes', 'Race Brakes'},
        [13] = {'Stock Transmission', 'Street Transmission', 'Sport Transmission', 'Race Transmission'},
        [15] = {'Stock Suspension', 'Lowered Suspension', 'Street Suspension', 'Sport Suspension', 'Competition Suspension'},
        [16] = {'No Armor', 'Armor Upgrade 20%', 'Armor Upgrade 40%', 'Armor Upgrade 60%', 'Armor Upgrade 80%', 'Armor Upgrade 100%'}
    }
    
    local options = {}
    
    -- Stock/Remove option
    table.insert(options, {
        label = 'Stock / Remove',
        description = currentMod == -1 and 'Currently Active' or 'Click to apply',
        icon = 'xmark',
        iconColor = currentMod == -1 and '#00ff00' or '#ff0000'
    })
    
    -- Mod options
    for i = 0, maxMod - 1 do
        local modDisplayName
        
        if performanceLabels[modType] and performanceLabels[modType][i + 1] then
            modDisplayName = performanceLabels[modType][i + 1]
        else
            local modLabel = GetModTextLabel(vehicle, modType, i)
            local labelText = GetLabelText(modLabel)
            
            if labelText and labelText ~= modLabel and labelText ~= 'NULL' then
                modDisplayName = labelText
            else
                modDisplayName = 'Upgrade ' .. (i + 1)
            end
        end
        
        local isActive = currentMod == i
        
        table.insert(options, {
            label = modDisplayName,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'check',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            args = {modIndex = i, modDisplayName = modDisplayName}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to ' .. modName:lower(),
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'specific_mod_menu',
        title = modName,
        position = 'top-right',
        
        onClose = function()
            if parentMenu == 'performance_mods_menu' then
                openPerformanceModsMenu()
            elseif parentMenu == 'visual_mods_menu' then
                openVisualModsMenu()
            end
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            RemoveVehicleMod(vehicle, modType)
            lib.notify({title = modName, description = 'Removed', type = 'success'})
            openSpecificModMenu(modType, modName, parentMenu)
        elseif selected == #options then
            if parentMenu == 'performance_mods_menu' then
                openPerformanceModsMenu()
            elseif parentMenu == 'visual_mods_menu' then
                openVisualModsMenu()
            end
        elseif options[selected].args then
            SetVehicleMod(vehicle, modType, options[selected].args.modIndex, false)
            lib.notify({title = modName, description = options[selected].args.modDisplayName, type = 'success'})
            openSpecificModMenu(modType, modName, parentMenu)
        end
    end)
    
    lib.showMenu('specific_mod_menu')
end

-- Window Tint Menu
function openWindowTintMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local tints = {
        {name = 'None', id = 0},
        {name = 'Pure Black', id = 1},
        {name = 'Dark Smoke', id = 2},
        {name = 'Light Smoke', id = 3},
        {name = 'Stock', id = 4},
        {name = 'Limo', id = 5},
        {name = 'Green', id = 6}
    }
    
    local options = {}
    local currentTint = GetVehicleWindowTint(vehicle)
    
    for _, tint in ipairs(tints) do
        local isActive = currentTint == tint.id
        table.insert(options, {
            label = tint.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'window-maximize',
            iconColor = isActive and '#00ff00' or '#696969',
            args = {tintId = tint.id, tintName = tint.name}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to visual mods',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'window_tint_menu',
        title = 'Window Tint',
        position = 'top-right',
        
        onClose = function()
            openVisualModsMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openVisualModsMenu()
        else
            SetVehicleWindowTint(vehicle, options[selected].args.tintId)
            lib.notify({title = 'Window Tint Changed', description = options[selected].args.tintName, type = 'success'})
            openWindowTintMenu()
        end
    end)
    
    lib.showMenu('window_tint_menu')
end

-- Neon Lights Menu
function openNeonLightsMenu(startIndex)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local neonPositions = {
        {id = 0, name = 'Left'},
        {id = 1, name = 'Right'},
        {id = 2, name = 'Front'},
        {id = 3, name = 'Back'}
    }
    
    local options = {}
    
    -- Toggle all neons
    local allEnabled = true
    for _, pos in ipairs(neonPositions) do
        if not IsVehicleNeonLightEnabled(vehicle, pos.id) then
            allEnabled = false
            break
        end
    end
    
    table.insert(options, {
        label = allEnabled and 'Disable All Neons' or 'Enable All Neons',
        description = 'Toggle all neon lights',
        icon = 'lightbulb',
        iconColor = allEnabled and '#ff0000' or '#00ff00'
    })
    
    -- Individual neon positions
    for _, pos in ipairs(neonPositions) do
        local isEnabled = IsVehicleNeonLightEnabled(vehicle, pos.id)
        table.insert(options, {
            label = pos.name .. ' Neon',
            description = 'Status: ' .. (isEnabled and 'ON' or 'OFF'),
            icon = 'lightbulb',
            iconColor = isEnabled and '#00ff00' or '#ff0000',
            args = {posId = pos.id, posName = pos.name}
        })
    end
    
    -- Neon color option
    table.insert(options, {
        label = 'Change Neon Color',
        description = 'Set custom RGB color',
        icon = 'palette',
        iconColor = '#FF1493'
    })
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to visual mods',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'neon_lights_menu',
        title = 'Neon Lights',
        position = 'top-right',
        
        onClose = function()
            openVisualModsMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            for _, pos in ipairs(neonPositions) do
                SetVehicleNeonLightEnabled(vehicle, pos.id, not allEnabled)
            end
            lib.notify({title = 'Neon Lights', description = allEnabled and 'All Disabled' or 'All Enabled', type = 'success'})
            Wait(50)
            openNeonLightsMenu(selected)
        elseif selected == #options then
            openVisualModsMenu()
        elseif selected == #options - 1 then
            local r, g, b = GetVehicleNeonLightsColour(vehicle)
            local input = lib.inputDialog('Neon Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleNeonLightsColour(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Neon Color Changed', type = 'success'})
            end
            Wait(50)
            openNeonLightsMenu(selected)
        elseif options[selected].args then
            local isEnabled = IsVehicleNeonLightEnabled(vehicle, options[selected].args.posId)
            SetVehicleNeonLightEnabled(vehicle, options[selected].args.posId, not isEnabled)
            lib.notify({title = options[selected].args.posName .. ' Neon', description = isEnabled and 'Disabled' or 'Enabled', type = 'success'})
            Wait(50)
            openNeonLightsMenu(selected)
        end
    end)
    
    lib.showMenu('neon_lights_menu', startIndex or 1)
end

-- Wheels Menu
function openWheelColorMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local colors = {
        {name = 'Black', id = 0}, {name = 'Carbon Black', id = 147}, {name = 'Graphite', id = 1},
        {name = 'Steel', id = 3}, {name = 'Silver', id = 4}, {name = 'Frost White', id = 111},
        {name = 'Red', id = 27}, {name = 'Hot Pink', id = 135}, {name = 'Orange', id = 38},
        {name = 'Yellow', id = 88}, {name = 'Dark Green', id = 49}, {name = 'Lime Green', id = 92},
        {name = 'Blue', id = 64}, {name = 'Purple', id = 145}, {name = 'Gold', id = 37}
    }
    
    local options = {}
    local currentColor = GetVehicleExtraColours(vehicle)
    
    for _, color in ipairs(colors) do
        local isActive = currentColor == color.id
        table.insert(options, {
            label = color.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'circle',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            args = {colorId = color.id, colorName = color.name}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to wheel accessories',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'wheel_color_menu',
        title = 'Wheel Color',
        position = 'top-right',
        
        onClose = function()
            openWheelAccessoriesMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openWheelAccessoriesMenu()
        else
            local _, pearl = GetVehicleExtraColours(vehicle)
            SetVehicleExtraColours(vehicle, pearl or 0, options[selected].args.colorId)
            lib.notify({title = 'Wheel Color Changed', description = options[selected].args.colorName, type = 'success'})
            openWheelColorMenu()
        end
    end)
    
    lib.showMenu('wheel_color_menu')
end

function openWheelAccessoriesMenu(startIndex)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local options = {}
    
    -- Custom Tires
    local hasCustomTires = GetVehicleModVariation(vehicle, 23)
    table.insert(options, {
        label = 'Custom Tires',
        description = 'Status: ' .. (hasCustomTires and 'ON' or 'OFF'),
        icon = 'circle-notch',
        iconColor = hasCustomTires and '#00ff00' or '#ff0000'
    })
    
    -- Tire Smoke Color
    table.insert(options, {
        label = 'Tire Smoke Color',
        description = 'Set custom RGB color',
        icon = 'cloud',
        iconColor = '#B0C4DE'
    })
    
    -- Bulletproof Tires
    local hasBulletproofTires = GetVehicleTyresCanBurst(vehicle) == false
    table.insert(options, {
        label = 'Bulletproof Tires',
        description = 'Status: ' .. (hasBulletproofTires and 'ON' or 'OFF'),
        icon = 'shield',
        iconColor = hasBulletproofTires and '#00ff00' or '#ff0000'
    })
    
    -- Wheel Color
    local currentMod = GetVehicleMod(vehicle, 23)
    if currentMod ~= -1 then
        table.insert(options, {
            label = 'Change Wheel Color',
            description = 'Modify wheel rim color',
            icon = 'palette',
            iconColor = '#FFD700'
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to wheels menu',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'wheel_accessories_menu',
        title = 'Wheel Accessories',
        position = 'top-right',
        
        onClose = function()
            openWheelsMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            local currentMod = GetVehicleMod(vehicle, 23)
            if currentMod ~= -1 then
                SetVehicleMod(vehicle, 23, currentMod, not hasCustomTires)
                lib.notify({title = 'Custom Tires', description = hasCustomTires and 'Disabled' or 'Enabled', type = 'success'})
            else
                lib.notify({title = 'Error', description = 'Install custom wheels first', type = 'error'})
            end
            Wait(50)
            openWheelAccessoriesMenu(selected)
        elseif selected == 2 then
            local r, g, b = GetVehicleTyreSmokeColor(vehicle)
            local input = lib.inputDialog('Tire Smoke Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleModKit(vehicle, 0)
                ToggleVehicleMod(vehicle, 20, true)
                SetVehicleTyreSmokeColor(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Tire Smoke Color Changed', type = 'success'})
            end
            Wait(50)
            openWheelAccessoriesMenu(selected)
        elseif selected == 3 then
            SetVehicleTyresCanBurst(vehicle, hasBulletproofTires)
            lib.notify({title = 'Bulletproof Tires', description = hasBulletproofTires and 'Disabled' or 'Enabled', type = 'success'})
            Wait(50)
            openWheelAccessoriesMenu(selected)
        elseif selected == 4 and currentMod ~= -1 then
            openWheelColorMenu()
        elseif selected == #options then
            openWheelsMenu()
        end
    end)
    
    lib.showMenu('wheel_accessories_menu', startIndex or 1)
end

function openWheelModMenu(wheelType, wheelTypeName, parentMenu)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    SetVehicleWheelType(vehicle, wheelType)
    
    local maxMod = GetNumVehicleMods(vehicle, 23)
    local currentMod = GetVehicleMod(vehicle, 23)
    
    local options = {}
    
    -- Stock wheels option
    table.insert(options, {
        label = 'Stock Wheels',
        description = currentMod == -1 and 'Currently Active' or 'Click to apply',
        icon = 'circle',
        iconColor = currentMod == -1 and '#00ff00' or '#ff0000'
    })
    
    -- Wheel options
    for i = 0, maxMod - 1 do
        local modLabel = GetModTextLabel(vehicle, 23, i)
        local labelText = GetLabelText(modLabel)
        local modDisplayName
        
        if labelText and labelText ~= modLabel and labelText ~= 'NULL' then
            modDisplayName = labelText
        else
            modDisplayName = wheelTypeName .. ' Wheel ' .. (i + 1)
        end
        
        local isActive = currentMod == i
        
        table.insert(options, {
            label = modDisplayName,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'circle',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            args = {wheelIndex = i, wheelName = modDisplayName}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to wheels menu',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'wheel_mod_menu',
        title = wheelTypeName .. ' Wheels',
        position = 'top-right',
        
        onClose = function()
            openWheelsMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            RemoveVehicleMod(vehicle, 23)
            lib.notify({title = 'Wheels', description = 'Stock wheels applied', type = 'success'})
            openWheelModMenu(wheelType, wheelTypeName, parentMenu)
        elseif selected == #options then
            openWheelsMenu()
        else
            SetVehicleWheelType(vehicle, wheelType)
            SetVehicleMod(vehicle, 23, options[selected].args.wheelIndex, false)
            lib.notify({title = 'Wheels', description = options[selected].args.wheelName, type = 'success'})
            openWheelModMenu(wheelType, wheelTypeName, parentMenu)
        end
    end)
    
    lib.showMenu('wheel_mod_menu')
end

function openWheelsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local wheelCategories = {
        {type = 0, name = 'Sport', icon = 'gauge'},
        {type = 1, name = 'Muscle', icon = 'fire'},
        {type = 2, name = 'Lowrider', icon = 'car-side'},
        {type = 3, name = 'SUV', icon = 'truck'},
        {type = 4, name = 'Offroad', icon = 'mountain'},
        {type = 5, name = 'Tuner', icon = 'wrench'},
        {type = 6, name = 'Bike Wheels', icon = 'motorcycle'},
        {type = 7, name = 'High End', icon = 'gem'},
        {type = 11, name = 'Street', icon = 'road'},
        {type = 12, name = 'Track', icon = 'flag-checkered'}
    }
    
    local options = {
        {
            label = 'Wheel Accessories',
            description = 'Custom tires, smoke, bulletproof',
            icon = 'gears',
            iconColor = '#FFA500'
        }
    }
    
    for i, category in ipairs(wheelCategories) do
        table.insert(options, {
            label = category.name,
            description = 'Browse ' .. category.name:lower() .. ' wheels',
            icon = category.icon,
            iconColor = '#1E90FF',
            args = {wheelType = category.type, wheelName = category.name}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to visual mods',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'wheels_main_menu',
        title = 'Wheels',
        position = 'top-right',
        
        onClose = function()
            openVisualModsMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            openWheelAccessoriesMenu()
        elseif selected == #options then
            openVisualModsMenu()
        elseif options[selected].args then
            openWheelModMenu(options[selected].args.wheelType, options[selected].args.wheelName, 'wheels_main_menu')
        end
    end)
    
    lib.showMenu('wheels_main_menu')
end

-- Extras and Livery Menu
local function openExtrasAndLiveryMenu(startIndex)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local options = {}
    
    -- Add liveries section
    local liveryCount = GetVehicleLiveryCount(vehicle)
    if liveryCount > 0 then
        for i = 0, liveryCount - 1 do
            local currentLivery = GetVehicleLivery(vehicle)
            local isActive = currentLivery == i
            table.insert(options, {
                label = 'Livery ' .. (i + 1),
                description = isActive and 'Currently Active' or 'Click to apply',
                icon = 'paintbrush',
                iconColor = isActive and '#00ff00' or '#9370DB',
                args = {liveryIndex = i}
            })
        end
    end
    
    -- Add extras section
    local hasExtras = false
    for i = 0, 14 do
        if DoesExtraExist(vehicle, i) then
            hasExtras = true
            local isOn = IsVehicleExtraTurnedOn(vehicle, i)
            table.insert(options, {
                label = 'Extra ' .. i,
                description = 'Status: ' .. (isOn and 'ON' or 'OFF'),
                icon = isOn and 'toggle-on' or 'toggle-off',
                iconColor = isOn and '#00ff00' or '#ff0000',
                args = {extraId = i}
            })
        end
    end
    
    -- If no liveries or extras, show message
    if liveryCount <= 0 and not hasExtras then
        table.insert(options, {
            label = 'No Liveries or Extras',
            description = 'This vehicle has no liveries or extras',
            icon = 'circle-xmark',
            iconColor = '#ff0000'
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to customization',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'extras_livery_menu',
        title = 'Liveries & Extras',
        position = 'top-right',
        onClose = function()
            openVehicleCustomizationMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openVehicleCustomizationMenu()
        elseif options[selected].args and options[selected].args.liveryIndex then
            SetVehicleLivery(vehicle, options[selected].args.liveryIndex)
            lib.notify({title = 'Livery Changed', description = 'Livery ' .. (options[selected].args.liveryIndex + 1), type = 'success'})
            Wait(50)
            openExtrasAndLiveryMenu(selected)
        elseif options[selected].args and options[selected].args.extraId then
            local isOn = IsVehicleExtraTurnedOn(vehicle, options[selected].args.extraId)
            SetVehicleExtra(vehicle, options[selected].args.extraId, isOn and 1 or 0)
            lib.notify({title = 'Extra ' .. options[selected].args.extraId, description = isOn and 'Disabled' or 'Enabled', type = 'info'})
            Wait(50)
            openExtrasAndLiveryMenu(selected)
        end
    end)
    
    lib.showMenu('extras_livery_menu', startIndex or 1)
end

-- Horn Menu
local function openHornMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    local currentHorn = GetVehicleMod(vehicle, 14)
    
    local horns = {
        {name = 'Stock Horn', id = -1},
        {name = 'Truck Horn', id = 0},
        {name = 'Police Horn', id = 1},
        {name = 'Clown Horn', id = 2},
        {name = 'Musical Horn 1', id = 3},
        {name = 'Musical Horn 2', id = 4},
        {name = 'Musical Horn 3', id = 5},
        {name = 'Sad Trombone', id = 8},
        {name = 'Classical Horn 1', id = 9},
        {name = 'Jazz Horn 1', id = 24},
        {name = 'Festive 1 (Loop)', id = 40}
    }
    
    local options = {}
    
    for _, horn in ipairs(horns) do
        local isActive = currentHorn == horn.id
        table.insert(options, {
            label = horn.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'bullhorn',
            iconColor = isActive and '#00ff00' or '#FFA500',
            args = {hornId = horn.id, hornName = horn.name}
        })
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to customization',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'horn_menu',
        title = 'Vehicle Horn',
        position = 'top-right',
        onClose = function()
            openVehicleCustomizationMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openVehicleCustomizationMenu()
        else
            if options[selected].args.hornId == -1 then
                RemoveVehicleMod(vehicle, 14)
            else
                SetVehicleMod(vehicle, 14, options[selected].args.hornId, false)
            end
            lib.notify({title = 'Horn Changed', description = options[selected].args.hornName, type = 'success'})
            openHornMenu()
        end
    end)
    
    lib.showMenu('horn_menu')
end

-- Visual Mods Menu
function openVisualModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local visualMods = {
        {modType = 0, name = 'Spoilers', icon = 'car-rear'},
        {modType = 1, name = 'Front Bumper', icon = 'car-burst'},
        {modType = 2, name = 'Rear Bumper', icon = 'car-burst'},
        {modType = 3, name = 'Side Skirt', icon = 'car-side'},
        {modType = 4, name = 'Exhaust', icon = 'wind'},
        {modType = 5, name = 'Roll Cage', icon = 'shield'},
        {modType = 6, name = 'Grille', icon = 'table-cells'},
        {modType = 7, name = 'Hood', icon = 'car'},
        {modType = 8, name = 'Fender', icon = 'car-side'},
        {modType = 9, name = 'Right Fender', icon = 'car-side'},
        {modType = 10, name = 'Roof', icon = 'house'},
        {modType = 25, name = 'Suspension', icon = 'arrow-down-up-across-line'},
        {modType = 26, name = 'Armor', icon = 'shield-halved'},
        {modType = 27, name = 'Front Wheels', icon = 'circle'},
        {modType = 28, name = 'Back Wheels', icon = 'circle'},
        {modType = 30, name = 'Dial Design', icon = 'gauge'},
        {modType = 33, name = 'Steering Wheel', icon = 'circle-dot'},
        {modType = 34, name = 'Shifter Leavers', icon = 'gear'},
        {modType = 35, name = 'Plaques', icon = 'award'},
        {modType = 36, name = 'Speakers', icon = 'volume-high'},
        {modType = 37, name = 'Trunk', icon = 'box'},
        {modType = 38, name = 'Hydraulics', icon = 'up-down'},
        {modType = 39, name = 'Engine Block', icon = 'car-battery'},
        {modType = 40, name = 'Air Filter', icon = 'filter'},
        {modType = 41, name = 'Struts', icon = 'bars'},
        {modType = 42, name = 'Arch Cover', icon = 'car-side'},
        {modType = 43, name = 'Aerials', icon = 'tower-broadcast'},
        {modType = 44, name = 'Trim Design', icon = 'pen-ruler'},
        {modType = 45, name = 'Tank', icon = 'gas-pump'},
        {modType = 46, name = 'Windows', icon = 'window-maximize'},
        {modType = 48, name = 'Livery', icon = 'palette'}
    }
    
    local options = {
        {
            label = 'Window Tint',
            description = 'Change window tint level',
            icon = 'window-maximize',
            iconColor = '#696969'
        },
        {
            label = 'Neon Lights',
            description = 'Configure neon underglow',
            icon = 'lightbulb',
            iconColor = '#FF1493'
        },
        {
            label = 'Wheels',
            description = 'Browse wheels by category',
            icon = 'circle',
            iconColor = '#FFD700'
        }
    }
    
    for _, mod in ipairs(visualMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                label = mod.name,
                description = 'Configure ' .. mod.name:lower(),
                icon = mod.icon,
                iconColor = '#9370DB',
                args = {modType = mod.modType, modName = mod.name}
            })
        end
    end
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to customization',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'visual_mods_menu',
        title = 'Visual Modifications',
        position = 'top-right',
        
        onClose = function()
            openVehicleCustomizationMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            openWindowTintMenu()
        elseif selected == 2 then
            openNeonLightsMenu()
        elseif selected == 3 then
            openWheelsMenu()
        elseif selected == #options then
            openVehicleCustomizationMenu()
        elseif options[selected].args then
            openSpecificModMenu(options[selected].args.modType, options[selected].args.modName, 'visual_mods_menu')
        end
    end)
    
    lib.showMenu('visual_mods_menu')
end

function openVehicleCustomizationMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        openVehicleMenu()
        return
    end
    
    lib.registerMenu({
        id = 'vehicle_customization_menu',
        title = 'Vehicle Customization',
        position = 'top-right',
        
        onClose = function()
            openVehicleMenu()
        end,
        options = {
            {
                label = '← Back to Vehicle Menu',
                description = 'Return to vehicle menu',
                icon = 'arrow-left',
                iconColor = '#95a5a6'
            },
            {
                label = 'Repair Vehicle',
                description = '(Requires Mechanic for full repair)',
                icon = 'hammer',
                iconColor = '#f5ac0f'
            },
            {
                label = 'Clean Vehicle',
                description = 'Remove dirt from vehicle',
                icon = 'droplet',
                iconColor = '#00BFFF'
            },
            {
                label = 'Performance Mods',
                description = 'Engine, transmission, turbo, etc.',
                icon = 'gauge-high',
                iconColor = '#FF4500'
            },
            {
                label = 'Visual Mods',
                description = 'Spoilers, bumpers, wheels, etc.',
                icon = 'car',
                iconColor = '#9370DB'
            },
            {
                label = 'Change Primary Color',
                description = 'Modify primary paint color',
                icon = 'palette',
                iconColor = '#FF6347'
            },
            {
                label = 'Change Secondary Color',
                description = 'Modify secondary paint color',
                icon = 'palette',
                iconColor = '#4169E1'
            },
            {
                label = 'Liveries & Extras',
                description = 'Change liveries and toggle extras',
                icon = 'wrench',
                iconColor = '#FFA500'
            },
            {
                label = 'License Plate',
                description = 'Customize license plate',
                icon = 'address-card',
                iconColor = '#FFD700'
            },
            {
                label = 'Vehicle Horn',
                description = 'Change horn sound',
                icon = 'bullhorn',
                iconColor = '#FFA500'
            },
            {
                label = 'No Helmet',
                description = 'Status: ' .. (noHelmet and 'Enabled' or 'Disabled'),
                icon = noHelmet and 'toggle-on' or 'toggle-off',
                iconColor = noHelmet and '#00ff00' or '#ff0000'
            }
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            openVehicleMenu()
        elseif selected == 2 then
            ExecuteCommand('repair')
            openVehicleCustomizationMenu()
        elseif selected == 3 then
            SetVehicleDirtLevel(vehicle, 0.0)
            lib.notify({title = 'Vehicle Cleaned', type = 'success'})
            openVehicleCustomizationMenu()
        elseif selected == 4 then
            openPerformanceModsMenu()
        elseif selected == 5 then
            openVisualModsMenu()
        elseif selected == 6 then
            openPrimaryColorMenu()
        elseif selected == 7 then
            openSecondaryColorMenu()
        elseif selected == 8 then
            openExtrasAndLiveryMenu()
        elseif selected == 9 then
            openLicensePlateMenu()
        elseif selected == 10 then
            openHornMenu()
        elseif selected == 11 then
            noHelmet = not noHelmet
            lib.notify({title = 'No Helmet', description = noHelmet and 'Enabled' or 'Disabled', type = 'info'})
            openVehicleCustomizationMenu()
        end
    end)
    
    lib.showMenu('vehicle_customization_menu')
end

function openDoorsMenu(startIndex)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local doors = {
        {id = 0, name = 'Front Left Door'},
        {id = 1, name = 'Front Right Door'},
        {id = 2, name = 'Rear Left Door'},
        {id = 3, name = 'Rear Right Door'},
        {id = 4, name = 'Hood'},
        {id = 5, name = 'Trunk'}
    }
    
    local options = {}
    
    for _, door in ipairs(doors) do
        local isOpen = GetVehicleDoorAngleRatio(vehicle, door.id) > 0
        table.insert(options, {
            label = door.name,
            description = isOpen and 'Currently OPEN' or 'Currently CLOSED',
            icon = 'door-open',
            iconColor = isOpen and '#00ff00' or '#ff0000',
            args = {doorId = door.id, doorName = door.name}
        })
    end
    
    table.insert(options, {
        label = 'Close All Doors',
        description = 'Close all vehicle doors',
        icon = 'door-closed',
        iconColor = '#FFA500'
    })
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to vehicle menu',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'doors_menu',
        title = 'Vehicle Doors',
        position = 'top-right',
        onClose = function()
            openVehicleMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openVehicleMenu()
        elseif selected == #options - 1 then
            for i = 0, 5 do
                SetVehicleDoorShut(vehicle, i, false)
            end
            lib.notify({title = 'All Doors Closed', type = 'success'})
            Wait(50)
            openDoorsMenu(selected)
        else
            local currentVeh = GetVehiclePedIsIn(PlayerPedId(), false)
            local currentState = GetVehicleDoorAngleRatio(currentVeh, options[selected].args.doorId) > 0
            
            if currentState then
                SetVehicleDoorShut(currentVeh, options[selected].args.doorId, false)
                lib.notify({title = options[selected].args.doorName, description = 'Closed', type = 'success'})
            else
                SetVehicleDoorOpen(currentVeh, options[selected].args.doorId, false, false)
                lib.notify({title = options[selected].args.doorName, description = 'Opened', type = 'success'})
            end
            
            Wait(50)
            openDoorsMenu(selected)
        end
    end)
    
    lib.showMenu('doors_menu', startIndex or 1)
end

function openWindowsMenu(startIndex)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local windows = {
        {id = 0, name = 'Front Left Window'},
        {id = 1, name = 'Front Right Window'},
        {id = 2, name = 'Rear Left Window'},
        {id = 3, name = 'Rear Right Window'}
    }
    
    local options = {}
    
    for _, window in ipairs(windows) do
        table.insert(options, {
            label = window.name,
            description = 'Control window',
            icon = 'window-maximize',
            iconColor = '#4169E1',
            args = {windowId = window.id, windowName = window.name}
        })
    end
    
    table.insert(options, {
        label = 'Roll Down All Windows',
        description = 'Roll down all windows',
        icon = 'arrows-down-to-line',
        iconColor = '#00BFFF'
    })
    
    table.insert(options, {
        label = '← Back',
        description = 'Return to vehicle menu',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })
    
    lib.registerMenu({
        id = 'windows_menu',
        title = 'Vehicle Windows',
        position = 'top-right',
        onClose = function()
            openVehicleMenu()
        end,
        options = options
    }, function(selected, scrollIndex, args)
        if selected == #options then
            openVehicleMenu()
        elseif selected == #options - 1 then
            RollDownWindows(vehicle)
            lib.notify({title = 'All Windows Rolled Down', type = 'success'})
            Wait(50)
            openWindowsMenu(selected)
        else
            if IsVehicleWindowIntact(vehicle, options[selected].args.windowId) then
                RollDownWindow(vehicle, options[selected].args.windowId)
                lib.notify({title = options[selected].args.windowName, description = 'Rolled down', type = 'success'})
            else
                RollUpWindow(vehicle, options[selected].args.windowId)
                lib.notify({title = options[selected].args.windowName, description = 'Rolled up', type = 'success'})
            end
            Wait(50)
            openWindowsMenu(selected)
        end
    end)
    
    lib.showMenu('windows_menu', startIndex or 1)
end

function openVehicleMenu()
    lib.registerMenu({
        id = 'vehicle_main_menu',
        title = 'Vehicle Menu',
        position = 'top-right',
        onClose = function()
            -- Return to unified menu if it exists
            if lib.getOpenMenu() == nil then
                ExecuteCommand('menu')
            end
        end,
        options = {
            {
                label = '← Back to Main Menu',
                description = 'Return to unified menu',
                icon = 'arrow-left',
                iconColor = '#95a5a6'
            },
            {
                label = 'Vehicle Spawner',
                description = 'Browse and spawn vehicles',
                icon = 'car',
                iconColor = '#00BFFF'
            },
            {
                label = 'Vehicle Customization',
                description = 'Customize your current vehicle',
                icon = 'wrench',
                iconColor = '#FF8C00'
            },
            {
                label = 'Saved Vehicles',
                description = 'Manage your saved vehicles',
                icon = 'bookmark',
                iconColor = '#FFD700'
            },
            {
                label = 'Vehicle Doors',
                description = 'Control vehicle doors',
                icon = 'door-open',
                iconColor = '#9370DB'
            },
            {
                label = 'Vehicle Windows',
                description = 'Control vehicle windows',
                icon = 'window-maximize',
                iconColor = '#4169E1'
            }
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            ExecuteCommand('menu')
        elseif selected == 2 then
            openVehicleSpawnerMenu()
        elseif selected == 3 then
            openVehicleCustomizationMenu()
        elseif selected == 4 then
            openSavedVehiclesMenu()
        elseif selected == 5 then
            openDoorsMenu()
        elseif selected == 6 then
            openWindowsMenu()
        end
    end)
    
    lib.showMenu('vehicle_main_menu')
end

-- Command to open menu
RegisterCommand('veh', function() openVehicleMenu() end, false)