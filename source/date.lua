local daysInYears ={
    {31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30, 365},
    {31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30, 365},
    {31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31, 366},
    {31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30, 365},
    {31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30, 365},
    {31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30, 365},
    {31, 31, 32, 32, 31, 30, 30, 30, 29, 30, 30, 30, 366},
    {30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30, 365},
    {31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30, 365},
    {31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30, 365},
    {31, 32, 31, 32, 30, 31, 30, 30, 29, 30, 30, 30, 366},
    {30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30, 365},
    {31, 31, 32, 31, 31, 31, 30, 30, 29, 30, 30, 30, 366},
    {30, 31, 32, 32, 30, 31, 30, 30, 29, 30, 30, 30, 365}, 
}

-- The array daysInYears starts from 2075 Baisakh 1
-- That translates to 2018 April 14
-- The timestamp below is seconds from 2000,1,1 to 2018,3,14
-- as playdate time starts at 2000,1,1

local startingTimestamp = 574300800

function getDate(curSecFrom2000)
    local seconds = curSecFrom2000
    local daysSince = (seconds-startingTimestamp)/86400

    local monthCounter = 0

    for _, monthData in ipairs(daysInYears) do 
        for i = 1, 12 do
            daysSince = daysSince - monthData[i]
            if daysSince <= 0 then
                -- revert the last substraction in case we run out of days
                daysSince = daysSince + monthData[i]
                break
            else
                monthCounter = monthCounter + 1
            end
        end

        if daysSince <= 0 then
            break
        end
    end

    local year = monthCounter//12 + 2075
    local month = monthCounter % 12
    local day = math.floor(daysSince)

    return {year, month, day}
end

