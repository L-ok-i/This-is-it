Loki = {}
Loki.__index = Loki
Loki.type = 'loki'

local particle_system = {}

local dx = 0
local dy = 0
local lenght = 0

function Loki:particle_system_load(width, height, sum, speed, transparency, diagonal_movement)   
   for i=0, sum do
      local xr = math.random(0, width)
      local yr = math.random(height, height+400)
      particle_system[i] = 
      {xr, yr, math.random(speed[1]*100, speed[2]*100)/100, math.random(transparency[1], transparency[2]), math.random(diagonal_movement[1]*100, diagonal_movement[2]*100)/100} 
   end
end

function Loki:particle_system_update(width, height, transparency)
   for i=0, #particle_system do
      if particle_system[i][2] > 0 or ((particle_system[i][1] < width) and (particle_system[i][1] > 0)) then
         particle_system[i][1] = particle_system[i][1] + (particle_system[i][5] or 0)
         particle_system[i][2] = particle_system[i][2] - (particle_system[i][3] or math.random(1, 4))
         particle_system[i][3] = particle_system[i][3] + (1 - math.random(0, 200)/100)/10
         particle_system[i][5] = particle_system[i][5] + (1 - math.random(0, 200)/100)/10
      else 
         particle_system[i][1] = math.random(0, width)
         particle_system[i][2] = math.random(height, height+400)
      end
      if particle_system[i][4] > 0 then
         particle_system[i][4] = particle_system[i][4] - math.random(0.001, 0.1)
      else
         particle_system[i][4] = (math.random(transparency[1], transparency[2]) or 1)
      end
      if love.mouse.isDown(1) then
         local mouse_x, mouse_y = love.mouse.getPosition()
         dx = mouse_x - particle_system[i][1]
         dy = mouse_y - particle_system[i][2]
         lenght = math.sqrt(dx ^ 2 + dy ^ 2)
         dx = dx / lenght
         dy = dy / lenght
         particle_system[i][1] = particle_system[i][1] + dx / 0.1
         particle_system[i][2] = particle_system[i][2] + dy / 0.1
      end
   end
end

function Loki:particle_system_draw(color)
   for i=0, #particle_system do
      love.graphics.setColor(color[1], color[2], color[3], particle_system[i][4])
      love.graphics.rectangle('fill', particle_system[i][1], particle_system[i][2], 3, 3)
   end
end

return Loki