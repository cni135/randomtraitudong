-- AUTO RANDOM FRUIT (KHÔNG LƯU)
-- Tự random trái liên tục trong Blox Fruits

repeat task.wait() until game:IsLoaded()

while true do
    task.wait(2)

    pcall(function()

        game:GetService("ReplicatedStorage")
        .Remotes.CommF_:InvokeServer("Cousin","Buy")

    end)
end