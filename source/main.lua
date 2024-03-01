-- CoreLibs
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "monthDraw.lua"
import "date.lua"

-- playdate.display.setRefreshRate(1)

local img = playdate.graphics.image.new("image/menuimg.png")
playdate.setMenuImage(img)
playdate.getSystemMenu():addMenuItem("nirav ko",function()
end)

font_poppins = playdate.graphics.font.new("./font/font-pd-2") --poppinspd for full black
font_small_poppins = playdate.graphics.font.new("./font/popsmm")

-- turn off autolock
playdate.setAutoLockDisabled(true)

playdate.graphics.clear(0)

function updateTime()
    -- make black
    playdate.graphics.setColor(playdate.graphics.kColorBlack)
    playdate.graphics.fillRect(0, 0, 400, 205)

    -- display the bg image
    local img = playdate.graphics.image.new("image/buff")
    img:draw(17,17)

    -- set font to poppins
    playdate.graphics.setFont(font_poppins)

    -- draw time
    local time = playdate.getTime()

    local timeStr = string.format("%02d",time.hour) .. ":" .. string.format("%02d",time.minute)
    local fontWidth = font_poppins:getTextWidth(timeStr)
    playdate.graphics.drawText(timeStr, 200-fontWidth/2,140 )
    -- playdate.timer.performAfterDelay(60*1000, updateTime)
end

function updateDate()
    -- make black
    playdate.graphics.setColor(playdate.graphics.kColorBlack)
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

    playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeInverted)
    playdate.graphics.drawText(nepDate[3], 0,0 ) -- day
    monthDraw(nepDate[2], dayWidth + gapWidth, 0) -- month
    playdate.graphics.drawText(nepDate[1], dayWidth+gapWidth+monthWidth+gapWidth, 0)
    playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeCopy)

    playdate.graphics.setDrawOffset(0,0)

    -- playdate.timer.performAfterDelay(2*60*60*1000, updateDate)
end

function playdate.update()
    -- playdate.timer.updateTimers()
    updateTime()
    updateDate()
    playdate.wait(30*1000)
end


  




