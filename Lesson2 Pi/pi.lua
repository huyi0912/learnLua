local function writeLog(r, n, innerP, outerP, pi)
    local file = io.open("pi.log", "a+")
    if (file) then
        file:write("半徑 ", r, " 的圓,內接 ", n, "邊形周長 ", innerP, " 外接 ", n, "邊形周長 ", outerP, "逼近的 pi 為 ", pi, "\n")
        file:flush()
    end
    io.close(file)
end

local function sin(deg)
    return math.sin(math.rad(deg))
end
--函式: 計算內接多邊形周長
--參數: r:半徑 , n：多邊形個數
--回傳: 內接多邊形周長
local function calInnerP(r, n)
    local innerP = 0
    local degree = 360 / n
    innerP = 2 * n * sin(degree / 2) * r
    return innerP
end

local function tan(deg)
    return math.tan(math.rad(deg))
end

--函式: 計算外切多邊形周長
--參數: r:半徑 , n：多邊形個數
--回傳: 外切多邊形周長
local function calOuterP(r, n)
    local outerP = 0
    local degree = 360 / n
    outerP = 2 * n * tan(degree / 2) * r
    return outerP
end

--函式: 計算Pi
--參數: r:半徑 , innerP：內接多邊形周長, outerP:外切多邊形周長
--回傳: 近似 Pi
local function calPi(r, innerP, outerP)
    local pi = 0
    local p = (innerP + outerP) / 2
    pi = p / (r * 2)

    return pi
end


-- 目標 : 找出 pi 值
-- 方法 : 藉由 內接多邊形 與 外切多邊形 逼近方式找圓周 ,進而求出近似 pi
local running = true -- 代表目前程式是否執行中
while (running) do -- 當 running 為 true,執行下方程式
    io.write("Please input 請輸入圓的半徑(或0離開)?") -- 在螢幕上輸出請使用者輸入
    local r = io.read("n") --等待並讀取使用者輸入數字(n)

    if (r) then -- true 或 false,非 nil 都是 true
        if (r == 0) then
            running = false
            break
        end

        io.write("請輸入將圓等切成幾份(或0離開)?")
        local n = io.read("n")
        print("半徑=", r, ",幾邊=", n)

        if (n) then --合理的 多邊形數
            if (n == 0) then
                running = false
                break
            end
            --[[ ]] --
            --計算內接多邊形周長
            local innerP = calInnerP(r, n)
            --計算外切多邊形周長
            local outerP = calOuterP(r, n)
            --計算 Pi
            local pi = calPi(r, innerP, outerP)
            --輸出到 log 檔
            writeLog(r, n, innerP, outerP, pi)
        end
    end

    local linefeed = io.read("l")
end
