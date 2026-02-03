local sg = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", sg)

btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.5, -75, 0.15, 0)
btn.Text = "ВЗЛЕТ (ULTRA)"
btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 20
btn.Draggable = true

local active = false
local speed = 0.5

local function getHRP()
    local char = game.Players.LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function applyShield()
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanTouch = false
            end
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.Name = "Protected"
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if active then
        local hrp = getHRP()
        local char = game.Players.LocalPlayer.Character
        local hum = char and (char:FindFirstChildOfClass("Humanoid") or char:FindFirstChild("Protected"))
        if hrp and hum then
            hrp.CFrame = hrp.CFrame + Vector3.new(0, speed, 0)
            hrp.Velocity = Vector3.new(0, 0.05, 0)
            if tick() % 2 < 0.1 then
                hum:ChangeState(Enum.HumanoidStateType.Landed)
            end
        end
    end
end)

btn.MouseButton1Click:Connect(function()
    active = not active
    btn.Text = active and "СТОП" or "ВЗЛЕТ (ULTRA)"
    btn.TextColor3 = active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)
end)

game.Players.LocalPlayer.CharacterAdded:Connect(applyShield)
applyShield()
