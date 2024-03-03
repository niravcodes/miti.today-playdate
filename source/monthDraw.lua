local monthClips = {
    playdate.geometry.rect.new(0, 0, 64, 31),
    playdate.geometry.rect.new(67, 0, 44, 31),
    playdate.geometry.rect.new(117, 0, 60, 31),
    playdate.geometry.rect.new(182, 0, 59, 31),
    playdate.geometry.rect.new(246, 0, 38, 31),
    playdate.geometry.rect.new(289, 0, 64, 31),
    playdate.geometry.rect.new(359, 0, 75, 31),
    playdate.geometry.rect.new(437, 0, 55, 31),
    playdate.geometry.rect.new(495, 0, 37, 31), 
    playdate.geometry.rect.new(537, 0, 42, 31),
    playdate.geometry.rect.new(583, 0, 78, 31),
    playdate.geometry.rect.new(665, 0, 33, 31)
}

local monthNames = playdate.graphics.image.new("image/months_text")

-- month name load
function monthDraw(monthNo,x,y)
    local ox,oy = playdate.graphics.getDrawOffset()
    playdate.graphics.setDrawOffset(ox+x-monthClips[monthNo].x, oy+y-5) -- -5 to account for iikar uukar
    playdate.graphics.setClipRect(monthClips[monthNo])
    monthNames:draw(0,0)
    playdate.graphics.clearClipRect()
    playdate.graphics.setDrawOffset(ox,oy)
end

function getMonthWidth(monthNo)
    return monthClips[monthNo].width
end