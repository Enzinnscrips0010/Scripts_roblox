local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function AddHealthBar(player)
	if player == LocalPlayer then return end

	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		local head = character:WaitForChild("Head")

		-- ✅ TEAM CHECK
		if player.Team == LocalPlayer.Team then
			return -- não mostra aliados
		end

		-------------------------------------------------
		-- Barra de vida simples
		-------------------------------------------------
		local gui = Instance.new("BillboardGui")
		gui.Name = "EnemyHealthBar"
		gui.Size = UDim2.new(2, 0, 0.25, 0)
		gui.StudsOffset = Vector3.new(0, 2.5, 0)
		gui.AlwaysOnTop = true
		gui.Parent = head

		-- Fundo
		local bg = Instance.new("Frame")
		bg.Size = UDim2.new(1, 0, 1, 0)
		bg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		bg.BorderSizePixel = 0
		bg.Parent = gui

		-- Barra verde (vida)
		local bar = Instance.new("Frame")
		bar.Size = UDim2.new(1, 0, 1, 0)
		bar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		bar.BorderSizePixel = 0
		bar.Parent = bg

		-- Atualizar vida em tempo real
		local function UpdateHealth()
			local percent = humanoid.Health / humanoid.MaxHealth
			bar.Size = UDim2.new(percent, 0, 1, 0)
		end

		UpdateHealth()
		humanoid.HealthChanged:Connect(UpdateHealth)
	end)
end

-------------------------------------------------
-- Aplicar para todos
-------------------------------------------------
for _, p in pairs(Players:GetPlayers()) do
	AddHealthBar(p)
end

Players.PlayerAdded:Connect(AddHealthBar)
