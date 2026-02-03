local sg = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", sg)

btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.5, -75, 0.15, 0)
btn.Text = "STEALTH (OFF)"
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 18
btn.Draggable = true

local active = false

local function applyShield()
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                if v.Name:match("Leg") or v.Name:match("Foot") then
                    v.CanTouch = true
                else
                    v.CanTouch = false
                end
            end
        end
    end
end

local function updatePhys()
    local char = game.Players.LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        if active then
            hum.JumpPower = 120 -- Высокий прыжок (хватит на 2-3 этажа)
            hum.WalkSpeed = 32  -- Быстрый бег
        else
            hum.JumpPower = 50  -- Стандарт
            hum.WalkSpeed = 16  -- Стандарт
        end
    end
end

btn.MouseButton1Click:Connect(function()
    active = not active
    btn.Text = active and "STEALTH (ON)" or "STEALTH (OFF)"
    btn.TextColor3 = active and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
    updatePhys()
end)

task.spawn(function()
    while task.wait(1) do
        applyShield()
        updatePhys()
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    applyShield()
end)

applyShield()
