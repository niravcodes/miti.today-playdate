-- Importing libraries
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "monthDraw.lua"
import "date.lua"

-- Fonts
local font_poppins = playdate.graphics.font.new("./font/font-pd-2") --poppinspd for full black
local font_small_poppins = playdate.graphics.font.new("./font/popsmm")

-- Backgrounds
local buffImg = playdate.graphics.image.new("image/buff")
local roboImg = playdate.graphics.image.new("image/robot")
local mtnImg = playdate.graphics.image.new("image/wall")
local backgrounds = {["buffalo"] = buffImg, ["robot"]=roboImg, ["annapurna"]=mtnImg}
local bgImage = buffImg 

-- Playdate settings
playdate.graphics.setColor(playdate.graphics.kColorWhite)
-- playdate.display.setRefreshRate(1)
playdate.setAutoLockDisabled(true)


-- Pull saved settings if any
local settings = playdate.datastore.read()
if settings == nil then
    settings = {dark=false, bg="buffalo"}
    playdate.datastore.write(settings)
else
    if(settings.bg and settings.dark) then
        bgImage = backgrounds[settings.bg]
        if (settings.dark) then
            playdate.graphics.setColor(playdate.graphics.kColorBlack)
        else
            playdate.graphics.setColor(playdate.graphics.kColorWhite)
        end
    end
end


function updateTime()
    -- make black
    playdate.graphics.fillRect(0, 0, 400, 205)

    -- display the bg image
    bgImage:draw(17,17)

    -- set font to poppins
    playdate.graphics.setFont(font_poppins)

    -- draw time
    local time = playdate.getTime()
    local timeStr = string.format("%02d",time.hour) .. ":" .. string.format("%02d",time.minute)
    local fontWidth = font_poppins:getTextWidth(timeStr)
    playdate.graphics.drawText(timeStr, 200-fontWidth/2, 140)
end

function updateDate()
    -- make black
    playdate.graphics.fillRect(0, 205, 400, 240)

    -- set font to small regular poppins
    playdate.graphics.setFont(font_small_poppins)

    -- get time and date
    local nepDate = getDate(playdate.getSecondsSinceEpoch())

    local gapWidth = 7 
    local monthWidth = getMonthWidth(nepDate[2])
    local dayWidth = font_small_poppins:getTextWidth(nepDate[3])
    local yearWidth = font_small_poppins:getTextWidth(nepDate[1])
    local totalWidth = dayWidth + gapWidth + monthWidth + gapWidth + yearWidth

    local startingX = 200-totalWidth/2
    playdate.graphics.setDrawOffset(startingX, 206)

    if (settings.dark) then
        playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeInverted)
    end
    playdate.graphics.drawText(nepDate[3], 0,0 ) -- day
    monthDraw(nepDate[2], dayWidth + gapWidth, 0) -- month
    playdate.graphics.drawText(nepDate[1], dayWidth+gapWidth+monthWidth+gapWidth, 0)
    playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeCopy)
    playdate.graphics.setDrawOffset(0,0)
end

-- Menu items
local img = playdate.graphics.image.new("image/menuimg.png")
playdate.setMenuImage(img)
playdate.getSystemMenu():addMenuItem("nirav ko",function()
end)

playdate.getSystemMenu():addCheckmarkMenuItem("dark mode",settings.dark,function(value)
    settings.dark = value
    playdate.datastore.write(settings)

    if (value) then
        playdate.graphics.setColor(playdate.graphics.kColorBlack)
    else
        playdate.graphics.setColor(playdate.graphics.kColorWhite)
    end

    updateTime()
    updateDate()
end)

playdate.getSystemMenu():addOptionsMenuItem("image", {"buffalo", "annapurna", "robot"}, settings.bg, function (value)
    bgImage = backgrounds[value]
    settings.bg = value
    playdate.datastore.write(settings)
    updateTime()
    updateDate()
end)


function playdate.update()
    updateTime()
    updateDate()
    playdate.wait(40*1000)
end
