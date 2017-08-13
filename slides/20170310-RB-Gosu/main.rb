#coding: utf-8
require "gosu"
class GameWindow < Gosu::Window
  def initialize
    super(800,600)
    self.caption = "GameWindow"
    @sun = Gosu::Image.new(self,"./images/sun.png")
    @r = 200
    @angle = 0
    @v = 0.1
    @Zorder = {Sky: 0, Sun: 1, Mountain: 2, Ground: 3,UI: 4}
    @font = Gosu::Font.new(24)
  end  
  def update
    button_down?(Gosu::KbUp) and @r+=1
    button_down?(Gosu::KbDown) and @r-=1
    button_down?(Gosu::KbLeft) and @v+=0.01
    button_down?(Gosu::KbRight) and @v-=0.01
    button_down?(Gosu::KbEscape) and exit
    
    @angle -= @v
    @angle = @angle % 360
  end
  def draw
    draw_quad(  0,400,0xFF44BB22,800,400,0xFF117711,
              800,600,0xFF44BB33,  0,600,0xFF88BB33, @Zorder[:Ground])
    draw_quad(  0,  0,0xFF00FFFF,800,  0,0xFF00FFFF,
              800,400,0xFF00FFFF,  0,400,0xFF00FFFF, @Zorder[:Sky])
    draw_triangle(  0,400,0xFF008000,
                  150,400,0xFF338033,
                   75,300,0xFF508011, @Zorder[:Mountain])
    @sun.draw_rot(400 + @r * Math.cos(@angle.degrees_to_radians),
                  400 + @r * Math.sin(@angle.degrees_to_radians), @Zorder[:Sun],@angle)
    @font.draw("角度:%6.2f 半徑:%5d 速度:%.2f"%[@angle,@r,@v],10,10,@Zorder[:UI])
  end
end
game = GameWindow.new
game.show