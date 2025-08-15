-- LocalScript

-- 必要なサービスとオブジェクトの取得
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local playerListUI = script.Parent:WaitForChild("PlayerListFrame") -- UIのコンテナ名に合わせて変更

-- UIテンプレート
local playerTemplate = playerListUI:WaitForChild("PlayerTemplate")
playerTemplate.Visible = false

-- プレイヤーリストを更新する関数
local function updatePlayerList()
    -- 既存のUI要素を全てクリア
    for _, uiElement in ipairs(playerListUI:GetChildren()) do
        if uiElement.Name ~= "PlayerTemplate" then
            uiElement:Destroy()
        end
    end

    -- 全プレイヤーの位置をチェックしてUIに表示
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- テンプレートをクローン
            local playerFrame = playerTemplate:Clone()
            playerFrame.Name = player.Name
            playerFrame.Parent = playerListUI
            playerFrame.Visible = true

            -- 位置情報を表示
            local positionText = player.Character.HumanoidRootPart.Position
            playerFrame.TextLabel.Text = player.Name .. ": " .. math.floor(positionText.X) .. ", " .. math.floor(positionText.Y) .. ", " .. math.floor(positionText.Z)
            
            -- UIをリスト内に配置
            -- (UILayoutをPlayerListFrameに追加して自動で配置させることも可能)
        end
    end
end

-- 毎フレームUIを更新
RunService.Stepped:Connect(updatePlayerList)
