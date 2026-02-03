local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local bv = Instance.new("BodyVelocity")
bv.Velocity = Vector3.new(0, 50, 0) 
bv.MaxForce = Vector3.new(0, math.huge, 0) 
bv.Parent = hrp
