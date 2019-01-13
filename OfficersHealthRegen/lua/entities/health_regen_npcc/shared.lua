ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Health Regen NPC"
ENT.Author			= "@OfficerViars"
ENT.Contact			= "@OfficerViars"
ENT.Purpose			= "Health NPC"
ENT.Instructions	= "Health Regen"

ENT.Spawnable = true -- Put this one on false if you feel for it!

ENT.Category = "HealthRegenNPC"


ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.AutomaticFrameAdvance = true 

 function ENT:SetAutomaticFrameAdvance(bUsingAnim)
    self.AutomaticFrameAdvance = bUsingAnim
end