-- AUTO PIRATES + AUTO RANDOM + AUTO DROP FRUIT

repeat task.wait() until game:IsLoaded()

local player = game.Players.LocalPlayer
local enabled = false

-- =========================
-- UI
-- =========================
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

button.Text = "AUTO DROP : OFF"

button.MouseButton1Click:Connect(function()

    enabled = not enabled

    if enabled then
        button.Text = "AUTO DROP : ON"
    else
        button.Text = "AUTO DROP : OFF"
    end
end)

-- =========================
-- AUTO CHOOSE PIRATES
-- =========================
task.spawn(function()

    while true do
        task.wait(1)

        pcall(function()

            local gui = player.PlayerGui

            if gui:FindFirstChild("Main") then

                local main = gui.Main

                if main:FindFirstChild("ChooseTeam") then

                    local choose = main.ChooseTeam

                    if choose.Visible then

                        for _,v in pairs(choose:GetDescendants()) do

                            if v:IsA("TextButton")
                            and string.find(v.Text,"Pirates") then

                                firesignal(v.MouseButton1Click)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- =========================
-- REMOVE SPIN EFFECT
-- =========================
task.spawn(function()

    while true do
        task.wait(1)

        pcall(function()

            for _,v in pairs(game:GetDescendants()) do

                if v:IsA("BlurEffect")
                or v:IsA("ColorCorrectionEffect")
                or v:IsA("SunRaysEffect") then

                    v:Destroy()
                end
            end
        end)
    end
end)

-- =========================
-- AUTO RANDOM FRUIT
-- =========================
task.spawn(function()

    while true do
        task.wait(2)

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
        task.wait(0.2)

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
