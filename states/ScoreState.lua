--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

local nopoints = love.graphics.newImage('nopoints.png')
local gold = love.graphics.newImage('gold.png')
local silver = love.graphics.newImage('silver.png')
local bronze = love.graphics.newImage('bronze.png')

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    local medal = ''
    -- if score is zero then crack the window :)
    if self.score == 0 then
        love.graphics.draw(nopoints)
    elseif self.score < 5 then
        love.graphics.draw(bronze, (VIRTUAL_WIDTH / 2) - (bronze:getWidth() / 2), -100)
        medal = 'BRONZE'
    elseif self.score < 10 then
        love.graphics.draw(silver, (VIRTUAL_WIDTH / 2) - (silver:getWidth() / 2), -100)
        medal = 'SILVER'
    elseif self.score >= 10 then
        love.graphics.draw(gold, (VIRTUAL_WIDTH / 2) - (gold:getWidth() / 2), -100)
        medal = 'GOLD'
    end

    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 190, VIRTUAL_WIDTH, 'center')
    if self.score > 0 then 
        love.graphics.printf(medal .. " MEDAL", 0, 210, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 240, VIRTUAL_WIDTH, 'center')
end