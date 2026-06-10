--[[ global love ]]
--[[

function love.load()
    -- 確保項目目錄中有一個名為 fonts/Songti.ttc (宋體) 的字體文件
    font = love.graphics.newFont("fonts/Songti.ttc", 20)
    love.graphics.setFont(font)
end

function love.draw()
    love.graphics.print("你好, Love2D!", 400, 300)
end
]]

--[[
local x, y = 400, 300

function love.update(dt)
    -- 偵測鍵盤按鍵來改變座標
    if love.keyboard.isDown("right") then
        x = x + 200 * dt
    elseif love.keyboard.isDown("left") then
        x = x - 200 * dt
    end
    if love.keyboard.isDown("up") then
        y = y - 200 * dt
    elseif love.keyboard.isDown("down") then
        y = y + 200 * dt
    end
end


function love.draw()
    -- 畫出一個跟隨座標的圓圈
    love.graphics.circle("fill", x, y, 30)
    love.graphics.print("Move with left right button！", 10, 10)
end
]]


-- 定義一個全域變數來儲存圖片物件
local playerImage


local x, y = 100, 100
-- 1. love.load: 遊戲啟動時執行一次，用來載入資源
function love.load()
    -- 載入圖片檔案。
    -- 確保 "character.png" 與 main.lua 在同一個資料夾內。
    -- love.graphics.newImage 會傳回一個 Image 物件。
    playerImage = love.graphics.newImage("images/block.png")
    -- 確保項目目錄中有一個名為 fonts/Songti.ttc (宋體) 的字體文件
    font = love.graphics.newFont("fonts/Songti.ttc", 20)
    love.graphics.setFont(font)
end

-- 2. love.update: 遊戲邏輯更新（此範例暫時不用）
function love.update(dt)
    -- 偵測鍵盤按鍵來改變座標
    if love.keyboard.isDown("right") then
        x = x + 200 * dt
    elseif love.keyboard.isDown("left") then
        x = x - 200 * dt
    end
    if love.keyboard.isDown("up") then
        y = y - 200 * dt
    elseif love.keyboard.isDown("down") then
        y = y + 200 * dt
    end
end

-- 3. love.draw: 每幀執行，專門用來繪製畫面
function love.draw()
    -- 設置背景顏色（可選，讓畫面看起來乾淨點）
    love.graphics.clear(0, 0, 0) -- R, G, B

    -- 繪製圖片
    if playerImage then
        -- love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
        -- drawable: 要繪製的圖片物件
        -- x, y: 繪製的座標位置 (左上角為原點)
        love.graphics.draw(playerImage, x, y)

        love.graphics.print("pos (" .. x .. "," .. y .. ")", x, y - 20)
    else
        love.graphics.print("圖片載入失敗！", 100, 100)
    end
end
