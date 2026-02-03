local sg = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", sg)

btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.5, -75, 0.15, 0)
btn.Text = "ВЗЛЕТ (STEALTH)"
btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 18
btn.Draggable = true

local active = false
local speed = 0.45 

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
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        end
    end
end

task.spawn(function()
    while task.wait(0.8) do
        applyShield()
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if active then
        local hrp = getHRP()
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        
        if hrp and hum then
            local drift = (math.random(-10, 10) / 500)
            local microPause = math.random(1, 100)
            
            if microPause > 5 then
                hrp.CFrame = hrp.CFrame + Vector3.new(drift, speed + drift, drift)
                hrp.Velocity = Vector3.new(0, 0.1, 0)
            end
            
            if tick() % 3 < 0.1 then
                hum:ChangeState(Enum.HumanoidStateType.Landed)
            end
        end
    end
end)

btn.MouseButton1Click:Connect(function()
    active = not active
    btn.Text = active and "STEALTH ON" or "ВЗЛЕТ (STEALTH)"
    btn.TextColor3 = active and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end)

game.Players.LocalPlayer.CharacterAdded:Connect(applyShield)
applyShield()
