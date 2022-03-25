local Loki = require'Loki'


local Scene = {}
Scene.__index = Scene
Scene.type = 'scene'

local Logo = {}
Logo.__index = Logo
Logo.type = 'logo'
Scene = Logo

function Logo:load()
   self.main_logo = love.graphics.newImage('main_logo.png')
   self.x_main_logo = -700
   self.h = 600
   self.w = 900
end

function Logo:update(dt)
   if self.x_main_logo <  50 then
      self.x_main_logo = self.x_main_logo + 800 * dt
      Loki:particle_system_load(self.w, self.h, 300, {1, 6}, {0.7, 1.0}, {-2.0, 2.0})

   else
      Loki:particle_system_update(self.w, self.h, {0.4554, 0.999})
      self.x_main_logo = 50
      if love.keyboard.isDown('c') then
         Scene:scene_main_game()
         love:load()
      end
   end
end

function Logo:draw()
   love.graphics.setColor(1,1,1)
   love.graphics.draw(self.main_logo, self.x_main_logo, 60)
   love.graphics.print("By loki", 10, 2)
   if self.x_main_logo == 50 then
      Loki:particle_system_draw({0.6, 0.2, 0.1})
   end
end

function love.load()
   love.mouse.setVisible(false)
   love.img_mouse = love.graphics.newImage("cursor.png")
   Scene:load()
   end
function love.update(dt)
   Scene:update(dt)
end

function love.draw()
   Scene:draw()
   local mouse_x, mouse_y = love.mouse.getPosition()
   love.graphics.setColor(1,1,1)
   love.graphics.draw(love.img_mouse, mouse_x, mouse_y) 
end





