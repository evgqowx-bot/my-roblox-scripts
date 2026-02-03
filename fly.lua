local sg = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", sg)

btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.5, -75, 0.15, 0)
btn.Text = "ПРЫЖОК+"
btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 20
btn.Draggable = true

local active = false

local function getHRP()
    local char = game.Players.LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

game:GetService("RunService").Heartbeat:Connect(function()
    if active then
        local hrp = getHRP()
        if hrp then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, 35, hrp.Velocity.Z)
        end
    end
end)

btn.MouseButton1Click:Connect(function()
    active = not active
    btn.Text = active and "СТОП" or "ПРЫЖОК+"
    btn.TextColor3 = active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)
end)

local function antiRef()
    local char = game.Players.LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = false
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        end
    end
end

game.Players.LocalPlayer.CharacterAdded:Connect(antiRef)
antiRef()
