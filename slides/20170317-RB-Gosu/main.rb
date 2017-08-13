#coding: utf-8
require 'gosu'
class Point
  attr_reader :x,:y
  def initialize(x,y)
    @x,@y = x,y
  end
  def update(x,y)
    @x,@y = x,y
  end
  def draw(window,z)
    window.draw_line(@x-5,@y-5,Gosu::Color::RED,@x+5,@y+5,Gosu::Color::RED,z)
    window.draw_line(@x-5,@y+5,Gosu::Color::RED,@x+5,@y-5,Gosu::Color::RED,z)
  end
end
class GameWindow < Gosu::Window
  def initialize
    super(800,600)
    self.caption = "請直接輸入圖檔檔名"
    self.text_input = Gosu::TextInput.new
    @font = Gosu::Font.new(24)
    @Zorder = { Pic: 0,Point: 1, Font: 2}
    @points = [
      Point.new(200, 200), Point.new(600, 200),
      Point.new(600, 400), Point.new(200, 400)
    ]
  end
  def update
    text_input and 
    if button_down?(Gosu::KbReturn)
      @path = text_input.text
      self.text_input = nil
      @text = nil
      if File.exists?(@path)
        @pic = Gosu::Image.new(self, @path)
        @text = "你是擅長載入圖片的朋友呢:#{@path}"
      else
        @text = "你是擅長錯誤處理的朋友呢"
      end
    else        
      @text = text_input.text
    end
    if @drag
      @drag.update(mouse_x, mouse_y)
      button_down?(Gosu::MsLeft) or @drag = nil
    else
      button_down?(Gosu::MsLeft) and @drag = @points.select{|point| 
        (point.x - mouse_x)**2 + (point.y - mouse_y)**2 < 100
      }.first
    end
  end
  def needs_cursor?
    return true
  end
  def draw
    @points.each{|point| point.draw(self,@Zorder[:Point])}
    @pic&.draw_as_quad(@points[0].x, @points[0].y, 0xFFFFFFFF,
                       @points[1].x, @points[1].y, 0xFFFFFFFF,
                       @points[2].x, @points[2].y, 0xFFFFFFFF,
                       @points[3].x, @points[3].y, 0xFFFFFFFF, 
                       @Zorder[:Pic])
    @font.draw(@text, 10, 10, @Zorder[:Font])
  end
end
game = GameWindow.new
game.show