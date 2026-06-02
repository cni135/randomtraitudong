-- CHỌN PHE XONG MỚI BAY TỚI GACHA SEA 2
local player = game.Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")
repeat task.wait() until game:IsLoaded()

local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

local Pos = Vector3.new(
    -386.3,
    73.0,
    297.3
)

local function TweenTP(pos)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if not hrp then
        return
    end

    local dist = (hrp.Position - pos).Magnitude
    local speed = 300

    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(
            dist / speed,
            Enum.EasingStyle.Linear
        ),
        {
            CFrame = CFrame.new(pos)
        }
    )

    tween:Play()
    tween.Completed:Wait()
end

-- Đợi chọn phe và spawn nhân vật
repeat
    task.wait(1)
until player.Character
    and player.Character:FindFirstChild("HumanoidRootPart")
    and player.Character:FindFirstChild("Humanoid")
    and player.Character.Humanoid.Health > 0

task.wait(1) -- chờ map load thêm

TweenTP(Pos)

-- AUTO RANDOM FRUIT
task.spawn(function()
    while true do
        task.wait(0.5)

        pcall(function()
            game:GetService("ReplicatedStorage")
                .Remotes
                .CommF_
                :InvokeServer("Cousin","Buy")
        end)
    end
end)
TweenTP(Pos)
-- AUTO RANDOM + AUTO DROP FRUIT

local enabled = true

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local button = Instance.new("TextButton")
button.Parent = gui

button.Size = UDim2.new(0,170,0,45)
button.Position = UDim2.new(0,20,0,20)

button.BackgroundColor3 = Color3.fromRGB(30,30,30)
button.TextColor3 = Color3.fromRGB(255,255,255)
button.TextSize = 20
button.Font = Enum.Font.SourceSansBold

button.Text = "AUTO DROP : ON"

button.MouseButton1Click:Connect(function()

    enabled = not enabled

    if enabled then
        button.Text = "AUTO DROP : ON"
    else
        button.Text = "AUTO DROP : OFF"
    end
end)
-- =========================
-- AUTO RANDOM FRUIT
-- =========================
task.spawn(function()

    while true do
        task.wait(0.5)

        pcall(function()

            game:GetService("ReplicatedStorage")
            .Remotes.CommF_:InvokeServer(
                "Cousin",
                "Buy"
            )

        end)
    end
end)

-- =========================
-- AUTO DROP FRUIT
-- =========================
task.spawn(function()

    while true do
        task.wait(0.1)

        if enabled then

            pcall(function()

                local char = player.Character
                if not char then return end

                local tool =
                    char:FindFirstChildOfClass("Tool")

                if tool
                and (
                    string.find(tool.Name:lower(),"fruit")
                    or string.find(tool.Name:lower(),"quake")
                    or string.find(tool.Name:lower(),"magma")
                    or string.find(tool.Name:lower(),"light")
                ) then

                    tool.Parent = workspace
                end
            end)
        end
    end
end)
