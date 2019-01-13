-----------------------------------------------------
-- 				HEALTH REGEN CONFIG! --

HealthConfig = {}

HealthConfig.RecentlyBoughtHealth = 60 -- how many second until you can buy another health
HealthConfig.MainText = "Dr. Schultz" -- Main text on the NPC! The text in front of the NPC!
HealthConfig.Model = "models/Humans/Group03m/male_09.mdl" -- the model of the npc
HealthConfig.MaxHealth = 100 -- max health until you can not purchase anymore health
HealthConfig.RecentlyBoughtHealth = 60 -- How many seconds until you can purchase health again, 
HealthConfig.BuyAble = true -- if true then you have to purchase the health, if false then the health is free

HealthList = {

-- ["NAME INSIDE THE MENU"] = {price = price of it, amount = amount of it},

["10 Health"] = {price = 100, amount = 10},
["20 Health"] = {price = 200, amount = 20},
["30 Health"] = {price = 300, amount = 30},
["40 Health"] = {price = 400, amount = 40},
["50 Health"] = {price = 500, amount = 50},
["60 Health"] = {price = 600, amount = 60},
["70 Health"] = {price = 700, amount = 70},
["80 Health"] = {price = 800, amount = 80},
["90 Health"] = {price = 900, amount = 90},
["100 Health"] = {price = 1000, amount = 100},
}


HealthConfig.Language = {

	HealthPurchaseCooldown = "You've purchased health too recently! Please wait another %s second(s).",
	
	VendingMachineText = "[Police Vending Machine]",
	
	MaxHealth = "You have max health already",
	
	CannotAfford = "You do not have enough money",
	
	

}