local world
local ball = {}
local ground = {}


function love.load()
    -- 1. 設定遊戲視窗大小
    love.window.setMode(800, 600)

    -- 2. 建立 Box2D 世界 (參數為：X軸重力, Y軸重力)
    -- Y軸設為 9.81 * 60 (向下重力)，讓物體有明顯的下墜感
    world = love.physics.newWorld(0, 9.81 * 60, true)

    -- 3. 建立靜態地面 (Static Body)
    ground.body = love.physics.newBody(world, 400, 550, "static")       -- 位置在 (400, 550)
    ground.shape = love.physics.newRectangleShape(700, 20)              -- 寬 700, 高 20 的矩形
    ground.fixture = love.physics.newFixture(ground.body, ground.shape) -- 綁定身體與形狀

    -- 4. 建立動態小球 (Dynamic Body)
    ball.body = love.physics.newBody(world, 400, 100, "dynamic") -- 位置在 (400, 100)
    ball.shape = love.physics.newCircleShape(25)                 -- 半徑 25 的圓形

    -- 建立 Fixture 並設定密度 (Density)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1)
    ball.fixture:setRestitution(0.75) -- 設定彈力 (0 = 不彈, 1 = 完全彈回)
end

function love.update(dt)
    -- 5. 更新物理世界 (讓時間前進)
    world:update(dt)
end

function love.draw()
    -- 6. 繪製地面 (灰色矩形)
    love.graphics.setColor(0.5, 0.5, 0.5)
    -- 使用 getPoints 獲取矩形四個頂點的實際世界座標
    love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))

    -- 7. 繪製小球 (紅色圓形)
    love.graphics.setColor(1, 0, 0)
    -- 獲取小球目前的 X, Y 座標與半徑
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
end

function love.keypressed(key, scancode)
    -- 雙重保險：不論是字元判定為 "space"，還是物理按鍵是 "space"，皆觸發​
    local speed = 700          -- 單位是牛頓 (N)，可以根據需要調整這個值來改變小球的移動速度
    if key == "left" then      -- 按下左鍵
        ball.body:applyForce(-speed, 0)
    elseif key == "right" then --按下右鍵
        ball.body:applyForce(speed, 0)
    elseif scancode == "down" or scancode == "s" then
        -- 獲取小球目前的 X 與 Y 軸速度
        local vx, vy = ball.body:getLinearVelocity()

        -- 預防機制：只有當球在空中，或是雖然在地上但沒有完全靜止時才能拍
        -- 如果您希望在任何時候（包含在地上滾動時）都能拍，可以拿掉這個判斷

        -- 設定拍球的衝量強度（數值越大，拍得越猛烈）
        local slapImpulse = 1500

        -- 如果小球原本正在往上彈（vy < 0），我們希望先抵消它的上升速度
        if vy < 0 then
            -- 強制將 Y 軸速度歸零，讓拍擊感更扎實，不會被上升的慣性抵消
            ball.graphics = ball.body:setLinearVelocity(vx, 0)
        end

        -- 施加向下的瞬間衝量 (X軸為 0, Y軸為正數值)
        -- 後面的參數是施力點，設定在小球的質心 (ball.body:getWorldCenter())
        ball.body:applyLinearImpulse(0, slapImpulse, ball.body:getWorldCenter())
    end
end
