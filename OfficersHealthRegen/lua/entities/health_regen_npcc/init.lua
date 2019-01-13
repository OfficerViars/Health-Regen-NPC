AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
resource.AddSingleFile( "resource/fonts/Belgrad.ttf" )
if CLIENT then return end
util.AddNetworkString( "GiveHealthRegen" )
util.AddNetworkString( "HealthRegen" )
util.AddNetworkString( "buyhealthandarmor" )
util.AddNetworkString("HealthRegen_Messages")

function ENT:Initialize()
	self:SetUseType(SIMPLE_USE)
    self:SetModel(HealthConfig.Model)
    self:SetHullSizeNormal()
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE || CAP_TURN_HEAD)


end 

function ENT:AcceptInput(activator, caller)
	net.Start("HealthRegen")
	net.Send(caller)
end

function buyhealthandarmor(ply, item, price, bool)
	net.Start("buyhealthandarmor")
		net.WriteString(tostring(item))
		net.WriteString(tostring(price))
		net.WriteBool(bool)
	net.Send(ply)
end

net.Receive("GiveHealthRegen", function(len, pl)
	local health = net.ReadString()
	if HealthList[health] then
		local healthAmount = HealthList[health].amount
		local price = HealthList[health].price
		local money = pl:getDarkRPVar("money")
		if IsValid(pl) and money > price and pl:Health() < HealthConfig.MaxHealth then
			if pl.boughtHealthRegenRecently == nil or CurTime() > pl.boughtHealthRegenRecently then
				local addHealth = pl:Health() + healthAmount
				pl:SetHealth(addHealth)
			if HealthConfig.BuyAble == true 
			then
				pl:addMoney(-price)
			end
				pl:EmitSound("items/battery_pickup.wav")
				buyhealthandarmor(pl, health, price, true)
				pl.boughtHealthRegenRecently = CurTime() + HealthConfig.RecentlyBoughtHealth
			else
				
				local timeLeft = string.sub(math.floor(CurTime() - pl.boughtHealthRegenRecently),2)
			
				net.Start( "HealthRegen_Messages" )
					net.WriteString( string.format( HealthConfig.Language.HealthPurchaseCooldown, timeLeft ) )
				net.Send(pl)
			end
		elseif( pl:Health() >= HealthConfig.MaxHealth ) then
			pl:ChatPrint(HealthConfig.Language.MaxHealth)
		if HealthConfig.Buyable == true then
		elseif( price > money ) then
			pl:ChatPrint(HealthConfig.Language.CannotAfford)
		end
		else
			pl:ChatPrint("You are not valid" )
		end
	end
end)

