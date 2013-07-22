local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW() * 0.9, ScrH() * 0.9)
	self:SetPaintBackgroundEnabled(false)
	self:SetPaintBorderEnabled(false)
	self:SetBackgroundColor(Color(0, 0, 0, 200))

	self:SetPos(-self:GetWide(), ScrH() * 0.05)

	self.slideInTime = self.slideInTime or 0.3
	self.toggled = false
end

function PANEL:slideIn()
	self.animationStart = RealTime()
	self.slideRight = true
	self.toggled = true
end

function PANEL:slideOut()
	self.animationStart = RealTime()
	self.slideRight = false
	self.toggled = false
end

function PANEL:setSlideInTime(time)
	self.slideInTime = time
end

function PANEL:AnimationThink()
	local realtime = RealTime()
	if (self.animationStart or 0) < (realtime - self.slideInTime) then return end

	local progress = (realtime - self.animationStart) / self.slideInTime * math.pi / 2
	progress = math.sin(progress)
	progress = self.slideRight and 1 - progress or progress

	local x, y = self:GetPos()
	self:SetPos(-self:GetWide() * progress, y)
end

derma.DefineControl("F1MenuPanel", "", PANEL, "DPanel")
