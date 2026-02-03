local ScreenGui = Instance.new("ScreenGui")
local Toggle = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Toggle.Name = "ToggleFly"
Toggle.Parent = ScreenGui
Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle.Position = UDim2.new(0.1, 0, 0.1, 0)
Toggle.Size = UDim2.new(0, 100, 0, 50)
Toggle.Text = "ВЗЛЕТ"
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)

local flying = false
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(0, math.huge, 0)

Toggle.MouseButton1Click:Connect(function()
    flying = not flying
    local char = game.Players.LocalPlayer.Character
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    if flying then
        bv.Parent = hrp
        bv.Velocity = Vector3.new(0, 35, 0) -- Скорость 35 меньше палится, чем 50
        Toggle.Text = "СТОП"
        Toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    else
        bv.Parent = nil
        Toggle.Text = "ВЗЛЕТ"
        Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    end
end)
