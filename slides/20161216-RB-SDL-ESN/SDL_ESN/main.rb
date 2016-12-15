#!/usr/bin/ruby
#coding: utf-8

require 'ruby-sdl-ffi'
class RedChess
  attr_reader :location
  @@init_location=[1,2,3,6,7,11].shuffle!
  @@init_count=1
  def initialize
    @id=@@init_count
    @pic=SDL.LoadBMP("R#{@id}.bmp")
    SDL.SetColorKey(@pic,SDL::SRCCOLORKEY,0x00FF00FF)
    
    @location=@@init_location.pop
    @@init_count+=1
        
    @x=(@location-1)%5
    @y=(@location-1)/5
  end
  def draw(screen)
    SDL.BlitSurface(@pic,nil,screen,SDL::Rect.new([@x*100,@y*100,0,0]))
  end
  def move(direct)
    result = case direct
    when 6
      @x<4 and @location+=1
    when 2
      @y<4 and @location+=5
    when 3 
      (@x<4&&@y<4) and @location+=6
    end
        
    @x=(@location-1)%5
    @y=(@location-1)/5
    
    result
  end
  def to_i
    @id
  end
  def inspect
    "<R#{@id} @#{@location}=[#{@x},#{@y}]>"
  end
end
class BlueChess
  attr_reader :location
  @@init_location=[15,19,20,23,24,25].shuffle!
  @@init_count=1
  def initialize
    @id=@@init_count
    @pic=SDL.LoadBMP("B#{@id}.bmp")
    SDL.SetColorKey(@pic,SDL::SRCCOLORKEY,0x00FF00FF)
    
    @location=@@init_location.pop
    @@init_count+=1
    
    @x=(@location-1)%5
    @y=(@location-1)/5
  end
  def draw(screen) 
    SDL.BlitSurface(@pic,nil,screen,SDL::Rect.new([@x*100,@y*100,0,0]))
  end
  def move(direct)
    result = 
    case direct
    when 4
      @x>0 and @location-=1
    when 8
      @y>0 and @location-=5
    when 7 
      (@x>0&&@y>0) and @location-=6
    end
    
    @x=(@location-1)%5
    @y=(@location-1)/5
    
    result
  end
  def to_i
    @id+10
  end
  def inspect
    "<B#{@id} @#{@location}=[#{@x},#{@y}]>"
  end
end
class Game
  @@RED=0
  @@BLUE=10
  def self.init
    SDL.Init(SDL::INIT_VIDEO)
    @Screen=SDL.SetVideoMode(500,500,32,SDL::SWSURFACE)
    
    @chesses=Array.new(12){|i|
      (i<6) ? RedChess.new : BlueChess.new
    }
    @turn=@@RED
    round_start
  end
  def self.round_start
    @turn=10-@turn
    @state=:move
    @dice=rand(6)+1
    
    @state=:select unless @chesses.any?{|chess| chess.to_i==@dice+@turn}
    if @state==:select&&dice=(single||side_single)
      @dice=dice
      @state=:move
    end
    
    SDL.WM_SetCaption("#{(@turn==@@RED)?"RED":"BLUE"} can #{@state} #{@dice}","")
  end
  def self.single
    case @turn
    when @@RED
      domain=@chesses[0...6]
      left=@chesses[0...@dice]
      right=@chesses[@dice...6]
    when @@BLUE
      domain=@chesses[6...12]
      left=@chesses[6...6+@dice]
      right=@chesses[6+@dice...12]
    end
    domain.compact.size==1 and domain[domain.index{|e| !e.nil?}].to_i-@turn
  end
  def self.side_single
    left=right=nil
    case @turn
    when @@RED
      left=@chesses[0...@dice].compact
      right=@chesses[@dice...6].compact
    when @@BLUE
      left=@chesses[6...6+@dice].compact
      right=@chesses[6+@dice...12].compact
    end
    
    if left.empty? then right.first.to_i-@turn
    elsif right.empty? then left.last.to_i-@turn
    end
  end
  def self.select(dice)
    left=right=nil
    case @turn
    when @@RED
      left=@chesses[0...@dice]
      right=@chesses[@dice...6]
    when @@BLUE
      left=@chesses[6...6+@dice]
      right=@chesses[6+@dice...12]
    end
    
    left.compact.last.to_i==dice+@turn or 
    right.compact.first.to_i==dice+@turn
  end
  def self.move(dice,direct)
    chess=@chesses.select{|c| c.to_i==dice+@turn}[0]
    target=chess.move(direct)
    @chesses.map!{|c|
      if c&.location==target&&c!=chess then nil
      else c
      end
    }
    target
  end
  def self.update
    case event=SDL.PollEvent
    when SDL::KeyboardEvent
      event.type==SDL::KEYDOWN and 
      case @state
      when :select
        case sym=event.keysym.sym
        when SDL::K_KP1..SDL::K_KP6
          dice=sym-SDL::K_KP0
          if select(dice)
            @state=:move
            @dice=dice
            SDL.WM_SetCaption("#{(@turn==@@RED)?"RED":"BLUE"} can move #{@dice}","")
          end
        when SDL::K_ESCAPE
          exit
        end
      when :move
        case sym=event.keysym.sym
        when SDL::K_KP7,SDL::K_KP8,SDL::K_KP4,SDL::K_KP6,SDL::K_KP3,SDL::K_KP2
          direct=sym-SDL::K_KP0
          move(@dice,direct) and round_start
        when SDL::K_ESCAPE
          exit
        end
      end
    when SDL::QuitEvent
      exit
    end
    @winner=check_winner
  end
  def self.draw_background
    SDL.FillRect(@Screen,SDL::Rect.new([0,0,500,500]),0x00FFFFFF)
    5.times{|i|
      SDL.FillRect(@Screen,SDL::Rect.new([100*(i+1),0,1,500]),0)
      SDL.FillRect(@Screen,SDL::Rect.new([0,100*(i+1),500,1]),0)
    }
  end
  def self.check_winner
    @chesses[0...6].compact.empty? and return @@BLUE
    @chesses[6...12].compact.empty? and return @@RED
    @chesses.any?{|c| c&.location==25&&c.instance_of?(RedChess)} and return @@RED
    @chesses.any?{|c| c&.location==1&&c.instance_of?(BlueChess)} and return @@BLUE
  end
  def self.draw
    draw_background
    @chesses.each{|chess| chess&.draw(@Screen)}
    SDL.Flip(@Screen)
  end
  def self.finish
    SDL.BlitSurface(SDL::LoadBMP("#{(@winner==@@RED)?"R":"B"}Win.bmp"),nil,@Screen,SDL::Rect.new([50,180,0,0]))
    SDL.Flip(@Screen)
    SDL.WM_SetCaption("#{(@winner==@@RED)?"RED":"BLUE"} wins","")
    SDL.Delay(3000)
  end
  def self.show
    init
    until(@winner)
      tick=SDL.GetTicks
      update
      draw
      SDL.Delay(16-(SDL.GetTicks-tick))
    end
    finish
  end
end
Game.show