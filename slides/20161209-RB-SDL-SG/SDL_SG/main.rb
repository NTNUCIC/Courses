#!/usr/bin/ruby
#coding: utf-8

#一定要引入SDL函式庫
require 'ruby-sdl-ffi'

class Ship
  attr_reader :x,:y,:w,:h,:hp
  def initialize(x,y)
    @ship = SDL::Image.Load("Ship.bmp")
    SDL.SetColorKey(@ship,SDL::SRCCOLORKEY,0xFF00FF)
    
    @x,@y = x,y
    @w,@h = @ship.w, @ship.h
    @speed = 3
   
    @hp = 100
    @sp = 0
  end
  def update(direct)
    case direct
    when 7
      @x-=@speed*2**-0.5
      @y-=@speed*2**-0.5
    when 8
      @y-=@speed
    when 9
      @x+=@speed*2**-0.5
      @y-=@speed*2**-0.5
    when 4
      @x-=@speed
    when 6
      @x+=@speed
    when 1
      @x-=@speed*2**-0.5
      @y+=@speed*2**-0.5
    when 2
      @y+=@speed
    when 3
      @x+=@speed*2**-0.5
      @y+=@speed*2**-0.5
    end
    @x = 0+@w/2 if @x<0+@w/2
    @y = 0+@h/2 if @y<0+@h/2
    @x = 400-@w/2 if @x>400-@w/2
    @y = 600-@h/2 if @y>600-@h/2
    
    @sp += 10
    @sp = 100 if @sp>100
  end
  def damage
    @hp -= 1
  end
  def alive?
    @hp > 0
  end
  def shootable?
    @sp == 100
  end
  def shoot
    shootable? and @sp = 0
  end
  def draw(screen)
    SDL.BlitSurface(@ship,nil,screen,SDL::Rect.new([@x-@w/2,@y-@h/2,0,0]))
  end
end
class Rock
  def initialize
    @id = [1,1,1,1,2,2,2,2,2,3,3,3,4].sample
    @pic = SDL.LoadBMP("Rock#{@id}.bmp")
    SDL.SetColorKey(@pic,SDL::SRCCOLORKEY,0xFF00FF)
    
    @w,@h = @pic.w,@pic.h
    @x,@y = rand(400-@w/2),-@h/2
    
    @hp = (@id==4)? 6 : 10 + rand(4)
  end
  def update
    @y += 5
  end
  def damage
    @hp -= 1
  end
  def over?
    @y-@h/2 > 600
  end
  def touch?(obj)
    (@x-obj.x).abs<=(@w+obj.w)/2 &&
    (@y-obj.y).abs<=(@h+obj.h)/2 
  end
  def alive?
    @hp > 0
  end
  def draw(screen)
    SDL.BlitSurface(@pic,nil,screen,SDL::Rect.new([@x-@w/2,@y-@h/2,0,0]))
  end
end
class Bullet
  attr_reader :x,:y,:w,:h
  def initialize(ship,left)
    @x = ship.x + (left ? -20 : 18)
    @y = ship.y - 18
    @w,@h = 2,10
  end
  def update
    @y -= 20
  end
  def over?
    @y < 0
  end
  def draw(screen)
    SDL.FillRect(screen,SDL::Rect.new([@x-@w/2,@y-@h/2,@w,@h]),0xFFFFFF)
  end
end
class Game
  def initialize
    #初始化SDL的繪圖功能
    SDL.Init(SDL::INIT_VIDEO)

    #取得螢幕400x600
    @Screen=SDL.SetVideoMode(400,600,32,SDL::SWSURFACE)

    SDL.WM_SetCaption("Ruby/SDL GAME","")
    
    @ship=Ship.new(200,500)
    @direct=5
    
    @rocks=[]
    
    @bullets=[]
    @shoot=false
    
    @score=0
  end
  def update
    case event=SDL.PollEvent
    when SDL::KeyboardEvent
      #按下了ESC就直接結束
      case event.type
      when SDL::KEYDOWN
        case event.keysym.sym
        when SDL::K_UP     then @direct+=3
        when SDL::K_DOWN   then @direct-=3
        when SDL::K_LEFT   then @direct-=1
        when SDL::K_RIGHT  then @direct+=1
        when SDL::K_z      then @shoot=true
        when SDL::K_ESCAPE then exit
        end
      when SDL::KEYUP
        case event.keysym.sym
        when SDL::K_UP    then @direct-=3
        when SDL::K_DOWN  then @direct+=3
        when SDL::K_LEFT  then @direct+=1
        when SDL::K_z     then @shoot=false
        when SDL::K_RIGHT then @direct-=1
        end
      end
    when SDL::MouseButtonEvent
      #只判斷按下滑鼠左鍵的狀況
      case event.button
      when SDL::BUTTON_LEFT
      end
    when SDL::QuitEvent
      #按下了右上角的關閉就直接結束
      exit
    end
    
    @ship.update(@direct)
    
    @bullets<<Bullet.new(@ship,true)<<Bullet.new(@ship,false) if @shoot && @ship.shoot
    @bullets.each(&:update)
    
    @rocks<<Rock.new if rand<0.15
    @rocks.each(&:update)
    origin_rock_count = @rocks.size
    @rocks.reject!(&:over?)
    @score += origin_rock_count - @rocks.size
    
    @bullets.reject!(&:over?)
    
    @rocks.reject!{|rock| rock.touch?(@ship) and @ship.damage }
    @rocks.each{|rock| 
      @bullets.each{|bullet|
        rock.touch?(bullet) and rock.damage
      }
    }
    @rocks.keep_if(&:alive?)
    
    SDL.WM_SetCaption("Score:#{@score} HP:#{@ship.hp}","")
    
    @end=true unless @ship.alive?
  end
  def draw
    SDL.FillRect(@Screen,SDL::Rect.new([0,0,400,600]),0)
    @ship.draw(@Screen)
    @rocks.each{|rock| rock.draw(@Screen)}
    @bullets.each{|bullet| bullet.draw(@Screen)}
    SDL.Flip(@Screen)
  end
  def show
    until(@end)
      update
      draw
      SDL.Delay(16)
    end
    record = File.open("Save.dat","rb"){|file| Marshal.load(file)} if File.exist?("save.dat") 
    record ||= 0
    if @score>record
      SDL.BlitSurface(SDL.LoadBMP("HighScore.bmp"),nil,@Screen,SDL::Rect.new([50,250,0,0]))
      File.open("Save.dat","wb"){|file| Marshal.dump(@score,file)}
    else
      SDL.BlitSurface(SDL.LoadBMP("GameOver.bmp"),nil,@Screen,SDL::Rect.new([50,250,0,0]))
    end
    SDL.Flip(@Screen)
    SDL.Delay(3000)
  end
end
game=Game.new
game.show