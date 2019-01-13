include("shared.lua")


surface.CreateFont( "maintext", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 80,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "healthtext", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 40,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


surface.CreateFont( "jailfood", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "cash", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 26,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "buytext", {
	font = "Belgrad", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local gradient = Material( 'vgui/gradient-r' )
local gradientl = Material( 'vgui/gradient-l' )

local sin,cos,rad = math.sin,math.cos,math.rad; --Only needed when you constantly calculate a new polygon, it slightly increases the speed.
function GeneratePoly(x,y,radius,quality)
    local circle = {};
    local tmp = 0;
    for i=1,quality do
        tmp = rad(i*360)/quality
        circle[i] = {x = x + cos(tmp)*radius,y = y + sin(tmp)*radius};
    end
    return circle;
end

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Up(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 85 - Ang:Right() * - 5 + Ang:Forward() * -0.50, Ang + Angle( 0, 0, 90 ), 0.067)
		surface.SetDrawColor(  0,0,0,150 )
		surface.DrawRect( -350, 43, 700, 120 )
		surface.SetDrawColor(  255,255,255,150 )
		surface.DrawOutlinedRect( -350, 45, 700, 120)
		draw.SimpleText( HealthConfig.MainText, "maintext", 0, 46, Color(255,255,255,150), 1, 0 )
	cam.End3D2D()


end
function FormatNumber( n )

	if not n then return "" end

	if n >= 1e14 then return tostring(n) end
	n = tostring(n)
	local sep = sep or ","
	local dp = string.find(n, "%.") or #n+1

	for i=dp-4, 1, -3 do

		n = n:sub(1, i) .. sep .. n:sub(i+1)	
	end

	return n
end

net.Receive("buyhealthandarmor", function(len)
	local item = net.ReadString()
	local price = net.ReadString()
	local i = net.ReadBool()
	if i then
		chat.AddText( Color( 20, 20, 255 ),"[HealthRegen] ", Color( 225, 225, 225 ), "You have purchased " .. item .. " for $" .. price)
	else
		chat.AddText( Color( 20, 20, 255 ),"[HealthRegen] ", Color( 225, 225, 225 ), "You have purchased " .. item .. " for $" .. price)
	end
end)


net.Receive("HealthRegen", function(len)

	openPageHealth()


end)



--[[---------------------------------------------------------


---------------------------------------------------------]]


function openPageHealth()
    local frame = vgui.Create("DFrame")
    frame:SetSize(883, 650)
    frame:Center()
    frame:SetTitle("")
    frame:SetSizable(true)
    frame:MakePopup()
    frame:ShowCloseButton( false )

    frame.Paint = function(self)
        draw.RoundedBox(0, 6, 0,871,50,Color( 31,33,41,255)) -- TOP
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )

		
		--surface.DrawOutlinedRect( 6, 25, 871, 20 )
	end

	local money  = LocalPlayer():getDarkRPVar("money") or 0
	local PlayerWallet 	= "$"..FormatNumber( money )
	playersmoney = vgui.Create( "DLabel", frame )
	playersmoney:SetPos( 15,20 )
	playersmoney:SetSize( 165, 18 )
	playersmoney:SetFont("cash")
	playersmoney:SetTextColor(Color(144,183,152,255))
	playersmoney:SetText ( "Cash: "..PlayerWallet )
	playersmoney.Paint = function(self, w, h)
			surface.SetDrawColor(32,30,39,255)
			surface.DrawRect( 0, 0, w+10, h+10 )
			surface.SetDrawColor( 32,30,39,255)
			surface.DrawOutlinedRect( 0, 0, w+10, h+10 )
		end
			
	CloseButton = vgui.Create( "DButton", frame )
	CloseButton:SetPos( 825,10 )
	CloseButton:SetSize( 30, 10 )
	CloseButton:SetText ( "" )
	CloseButton.Paint = function(self, w, h)
			--surface.SetDrawColor(234,15,60,255)
			--surface.DrawRect(0,0,20,100)
			draw.RoundedBox(3,0,0,30,5,Color( 234,15,60,180))
			--[[surface.SetDrawColor( 200,200,200, 150)
			surface.DrawRect( 0, 0, w, h )
			surface.SetDrawColor( 20,20,20, 150)
			surface.DrawOutlinedRect( 0, 0, w, h )]]--
	CloseButton.DoClick = function()
	frame:Close()
		end
	end
	
	local pagesback = vgui.Create( "DScrollPanel", frame)
	pagesback:SetPos(6, 45)
	pagesback:SetSize( 871, 630)
	pagesback.Paint = function (self, w, h)
	surface.SetDrawColor( 54,57,67,255) -- MAIN
	surface.DrawRect( 0, 0, w, h )
	surface.SetDrawColor( 255,255,255, 255)
	--surface.DrawOutlinedRect( 0, 0, w, h )
	--SHADOW MAIN
	surface.SetDrawColor( 60, 58, 70, 255 ) -- solid white, 0,0,0 is black
	surface.DrawRect( 0, 0, 880, 3 )

	local sbar = pagesback:GetVBar()
	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 51, 54, 65, 255 ) )
	end
	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 51, 54, 65, 255  ) )
	end
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 51, 54, 65, 255 ) )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 2, 0, w-4, h, Color( 61, 63, 73,255 ) )
	end

	---[-------------------------------------]
	end
	for k,v in pairs(HealthList) do
	
		local healthback = vgui.Create( "DPanel", pagesback)
		healthback:Dock( TOP )
		healthback:SetSize( 0, 200 )
		healthback:DockMargin( 5, 11, 5, 5)
		healthback.Paint = function (self, w, h )
			surface.SetDrawColor( 63,65,74,255) -- SLICES
			surface.DrawRect(0,0,w,h)

			--GRADIENT MAIN
			surface.SetMaterial( gradient )
			surface.SetDrawColor( 236, 21, 62, 255 ) -- solid white, 0,0,0 is black
			surface.DrawTexturedRect( 0, 195, 880, 5 )
			surface.SetMaterial( gradientl )
			surface.SetDrawColor( 252, 85, 85, 255 ) -- solid white, 0,0,0 is black
			surface.DrawTexturedRect( 0, 195, 880, 5 )
			---[-------------------------------------]
			GeneratePoly(0,0,50,300)

		end

		local healthnames = vgui.Create( "DLabel", healthback)
		healthnames:SetText(k)
		healthnames:Dock( FILL )
		healthnames:DockMargin( 75, 5, 0, 0 )
		healthnames:SetFont( "healthtext")
		healthnames:SetTextColor( Color(200,200,200,200) )
		healthnames:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	
		local healthmodels = vgui.Create( "DModelPanel", healthback)
		healthmodels:Dock( FILL )
		healthmodels:SetCamPos( Vector( 0, 200, 0 ) )
		healthmodels:SetLookAng( Angle( 180, 90, 180 ) )
		healthmodels:SetModel("models/Items/HealthKit.mdl")
		
		local healthprice = vgui.Create( "DLabel", healthback)
		healthprice:SetText("Price: $"..v.price)
		healthprice:Dock( FILL )
		healthprice:DockMargin( 75, 60, 0, 0 )
		healthprice:SetFont( "policearmory" )
		healthprice:SetTextColor( Color(200,200,200,200) )
		healthprice:SetExpensiveShadow( 2, Color(0,0,0, 200) )
		

		local hovcol = Color(200,200,200,255)
		local healthbutton = vgui.Create( "DButton", healthback)
		healthbutton:SetSize( 264, 35 )
		healthbutton:SetPos ( 650, 75 )
		healthbutton:SetText( "" )
		healthbutton.Paint = function( self, w, h )

		surface.SetDrawColor(25,27,36,255)
		surface.DrawRect( 3, 3, 150, 30 )

		surface.SetMaterial( gradient )
		surface.SetDrawColor( 236, 21, 62, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, 150, 30 )
		surface.SetMaterial( gradientl )
		surface.SetDrawColor( 252, 85, 85, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, 150, 30	 )

		
		--draw.RoundedBox( 0, 0, 0,self:GetWide(),self:GetTall(),Color(40,40,40,0))
		draw.SimpleText( "PURCHASE", "buytext", 10, 2, hovcol )

		if healthbutton:IsHovered() then
			hovcol = Color(255,138,131,255)
		else
			hovcol = Color(255,255,255,255)
		end	

		end
		healthbutton.DoClick = function()

			net.Start("GiveHealthRegen")
			net.WriteString( k )
			net.SendToServer()

		end
	end
end