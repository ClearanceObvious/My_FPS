--[[
  This should inside the main module "FPS.lua"
]]

local module = {}

local ts = game:GetService("TweenService")
local ti = TweenInfo.new(
	1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out,
	0, false, 0
)

offset = nil --Offset
keys = {} --Keyframes

function module:SetOffset(of: CFrameValue)
	offset = of
end
function module:SetKeyframes(ks: {})
	keys = ks
end
function module:SetTweenInfo(_ti: TweenInfo?)
	if _ti then
		ti = _ti
	else
		ti = TweenInfo.new(
			1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out,
			0, false, 0
		)
	end
end
function module:Run()
	for i, v: CFrame in pairs(keys) do
		local track = ts:Create(offset, ti, {
			Value = v
		})
		track:Play()
		track.Completed:Wait()
	end
	--Get to the base state
	local track = ts:Create(offset, ti, {
		Value = CFrame.new(0, 0, 0)
	})
	track:Play()
end
function module:GetProcessed()
	local track = ts:Create(offset, ti, {
		Value = keys[1]
	})
	return track
end

return module
