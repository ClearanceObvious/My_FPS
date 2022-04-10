--[[MY_FPS Framework
	
	Author: Tony (Tony_.#5397) on discord, if you have any questions / have found bugs please let me know
]]

local module = {}

--CONSTANTS / TYPES
export type PROCAnimation = {
	Time: number,
	Keyframe: {CFrame},
	EStyle: Enum.EasingStyle?,
	EDir: Enum.EasingDirection?
}

--Variables
local offset = CFrame.new(0, 0, 0)
local delta = 1
local main = workspace.CurrentCamera
local _declOffsets = {}
local object = nil

--Services
local run = game:GetService("RunService")

--Global Functions
function getTotalCF(offsets: {CFrameValue})
	local total = CFrame.new(0, 0, 0)
	
	if #offsets == 0 then
		return CFrame.new(0, 0, 0)
	end
	
	for i, v: CFrameValue in pairs(offsets) do
		total *= v.Value
	end
	
	return total
end

--Module Functions
function module:SetUp(amount_of_offsets: number)
	local x = {}
	local folder = Instance.new("Folder", game.Players.LocalPlayer)
	folder.Name = "Offsets"
	
	if amount_of_offsets <= 0 then
		return setmetatable(x, {__index = function()
			warn("Error Occured")
		end})
	end
	
	for i = 1, amount_of_offsets do
		local val = Instance.new("CFrameValue", folder)
		val.Name = "Offset " .. i
		x[#x+1] = val
	end
	
	_declOffsets = x
	
	return x
end
function module:SetMainSubject(obj: any?)
	if obj then
		main = obj
	else
		main = workspace.CurrentCamera
	end
end
function module:SetMainOffset(off: CFrame)
	offset = off
end
function module:SetInterpolationDelta(_delta: number)
	if _delta <= 0 or _delta > 1 then
		return
	end
	delta = _delta
end
function module:SetMainObject(obj)
	if obj.ClassName == "Model" then
		if not obj.PrimaryPart then
			warn("No Primary Part set on Model " .. obj.Name)
			return
		end
		object = obj
	else
		object = obj
	end
end
function module:LockFirstPerson()
	game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
end
function module:UnlockFirstPerson()
	game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
end
function module:Run()
	local cf
	local connection = run.RenderStepped:Connect(function()
		cf = main.CFrame * offset * getTotalCF(_declOffsets)
		
		if object.ClassName == "Model" then
			object:SetPrimaryPartCFrame(
				object:GetPrimaryPartCFrame():Lerp(cf, delta)
			)
		else
			object.CFrame = object.CFrame:Lerp(cf, delta)
		end
	end)
	
	return {
		Disable = function()
			connection:Disconnect()
		end,
	}
end
function module:CreateAnimation(ffs, anim: {PROCAnimation})
	local proc_keys = {}
	local animator = require(script.Animation)
	
	for i, v in pairs(anim) do
		local _ti = TweenInfo.new(
			v.Time,
			if v.EStyle then v.EStyle else Enum.EasingStyle.Quint,
			if v.EDir then v.EDir else Enum.EasingDirection.Out,
			0, false, 0
		)
		
		animator:SetKeyframes({v.Keyframe})
		animator:SetOffset(ffs)
		animator:SetTweenInfo(_ti)
		proc_keys[#proc_keys+1] = animator:GetProcessed()
	end
	animator:SetKeyframes({CFrame.new(0, 0, 0)})
	animator:SetOffset(ffs)
	animator:SetTweenInfo()
	proc_keys[#proc_keys+1] = animator:GetProcessed()
	
	return {
		Keyframes = proc_keys,
		Play = function(self)
			for i, v in pairs(self.Keyframes) do
				v:Play()
				v.Completed:Wait()
			end
		end,
	}
end

return module
