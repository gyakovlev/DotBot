--[[

DotBot by Affli@RU-Howling Fjord
All rights reserved.

]]--
local track={172,348,1120}
local DotBot=CreateFrame("Frame","DotBot",UIParent)
--dots={}
function mk()
if not dots then dots={} end
for k,v in ipairs(track)do
	local name,_,icon,_,_,_,_,_,_=GetSpellInfo(v)
	dots[name]={id=v,icon=icon}
end
end
	
function mkf()
	mk()
	for k,v in pairs(dots) do
		dot=CreateFrame("Frame","$parent_"..k,DotBot)
		dot:SetWidth(64)
		dot:SetHeight(64)
		local count=DotBot:GetNumChildren()
		if count==1 then
			dot:SetPoint("LEFT",UIParent,"CENTER")
		elseif count==2 then
			dot:SetPoint("LEFT",UIParent,"CENTER",68,0)
		else
			dot:SetPoint("LEFT",UIParent,"CENTER",68*(count-1),0)
		end
--		TukuiDB.SetTemplate(dot)
		dot.icon=dot:CreateTexture("$parentIcon","ARTWORK")
		dot.icon:SetTexture(v["icon"])
		dot.icon:SetAllPoints()

	--	dot.name=dot:CreateFontString("$parentName","ARTWORK")
	--	dot.name:SetPoint("BOTTOMLEFT",0,-12)
	--	dot.name:SetFont("Fonts\\ARIALN.TTF",12)
	--	dot.name:SetText(k)
		dot.damage=dot:CreateFontString("$parentDamage","ARTWORK")
		dot.damage:SetPoint("BOTTOMLEFT",0,-12)
		dot.damage:SetFont("Fonts\\ARIALN.TTF",12)
		dot.damage:SetText("")
		dot.id=v["id"]
		print(dot.sid)
		dot:SetScript("OnEvent", function(self,event,...)
			local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1,...)
				if eventType=="SPELL_PERIODIC_DAMAGE"and(sourceGUID==UnitGUID"player")then
					local spellId,_,spellSchool,amount,_,_,_,_,_,critical=select(9,...)
						if spellId==tonumber(self.id) then
							self.damage:SetText(amount)
							
						end
				end
		end)
		dot:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
end
