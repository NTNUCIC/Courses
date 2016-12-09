#!/usr/bin/ruby
#coding: utf-8

#一定要引入SDL函式庫
require 'ruby-sdl-ffi'

#玩家的太空船
class Ship
  #設定外部可以讀取以下實體變數
  attr_reader :x,:y,:w,:h,:hp
  #以外部給予的x,y初始化
  def initialize(x,y)
    #載入太空船圖片
    @ship = SDL::Image.Load("Ship.bmp")
    #圖片去背
    SDL.SetColorKey(@ship,SDL::SRCCOLORKEY,0xFF00FF)
    
    #將給予的x,y賦值給實體變數@x,@y
    @x,@y = x,y
    #以圖片大小來設定自身長和寬
    @w,@h = @ship.w, @ship.h
    #移動速度
    @speed = 3
   
    #生命計量以及能量計量
    @hp = 100
    @sp = 0
  end
  #每個畫格更新就傳入移動方向並且移動以及回復能量
  def update(direct)
    #數字鍵的9宮格定位
    #斜方向移動速度不變所以需要除以根號2
    case direct
    when 7
      @x-=@speed*2**-0.5
      @y-=@speed*2**-0.5
    when 8
      @y-=@speed
    when 9
      #? 往右上移動
    when 4
      #? 往左移動
    when 6
      @x+@speed
    when 1
      @x-=@speed*2**-0.5
      @y+=@speed*2**-0.5
    when 2
      #? 往下移動
    when 3
      @x+=@speed*2**-0.5
      @y+=@speed*2**-0.5
    end
    #避免圖片超出畫面範圍
    @x = 0+@w/2 if @x<0+@w/2
    @y = 0+@h/2 if @y<0+@h/2
    @x = 400-@w/2 if @x>400-@w/2
    @y = 600-@h/2 if @y>600-@h/2
    #能量增加以及限制最大值
    @sp += 10
    @sp = 100 if @sp>100
  end
  #受到損傷則生命下降
  def damage
    #? 自身hp降低1
  end
  #確認是否還存活
  def alive?
    #? hp大於0則存活
  end
  #能量已滿則為可射擊狀態
  def shootable?
    #? sp是否為100
  end
  #確認可否射擊並將能量計量歸零
  def shoot
    #? 呼叫shootable?並進行條件判斷
  end
  #把太空船以圖片中心為中心畫在給予的screen上
  def draw(screen)
    SDL.BlitSurface(@ship,nil,screen,SDL::Rect.new([@x-@w/2,@y-@h/2,0,0]))
  end
end
#野生的石頭
class Rock
  def initialize
    #以不同的機率產生自身外觀
    @id = [1,1,1,1,2,2,2,2,2,3,3,3,4].sample
    #載入圖片並去背
    @pic = SDL.LoadBMP("Rock#{@id}.bmp")
    SDL.SetColorKey(@pic,SDL::SRCCOLORKEY,0xFF00FF)
    
    #以圖片長寬設定自身長寬
    @w,@h = @pic.w,@pic.h
    #出現在螢幕上緣的隨機X軸上
    @x,@y = rand(400-@w/2),-@h/2
    
    #設定生命計量
    #起司比石頭要更容易破壞
    @hp = (@id==4)? 6 : 10 + rand(4)
  end
  #每個畫格向下移動5像素
  def update
    @y += 5
  end
  #受到傷害減少生命計量
  def damage
    @hp -= 1
  end
  #檢查整張圖是否超出螢幕範圍
  def over?
    @y-@h/2 > 600
  end
  #檢查是否撞到某物體
  def touch?(obj)
    (@x-obj.x).abs<=(@w+obj.w)/2 &&
    (@y-obj.y).abs<=(@h+obj.h)/2 
  end
  #生命大於0則存活
  def alive?
    @hp > 0
  end
  #將圖片繪製於給予的screen上
  def draw(screen)
    SDL.BlitSurface(@pic,nil,screen,SDL::Rect.new([@x-@w/2,@y-@h/2,0,0]))
  end
end
#自機子彈
class Bullet
  #設定外部可以讀取以下實體變數
  attr_reader :x,:y,:w,:h
  #因為需要初始位置所以需要船和發砲點
  def initialize(ship,left)
    @x = ship.x + (left ? -20 : 18)
    @y = ship.y - 18
    @w,@h = 2,10
  end
  #每個畫格向上移動20像素
  def update
    @y -= 20
  end
  #檢查是否超出螢幕
  def over?
    @y+@/2 < 0
  end
  #用矩形繪製於給予的screen上
  def draw(screen)
    SDL.FillRect(screen,SDL::Rect.new([@x-@w/2,@y-@h/2,@w,@h]),0xFFFFFF)
  end
end
#遊戲機制整合
class Game
  #遊戲初始化
  def initialize
    #初始化SDL的繪圖功能
    SDL.Init(SDL::INIT_VIDEO)

    #取得螢幕400x600
    @Screen=SDL.SetVideoMode(400,600,32,SDL::SWSURFACE)

    SDL.WM_SetCaption("Ruby/SDL GAME","")
    
    #玩家的太空船
    @ship=Ship.new(200,500)
    #預設沒有移動的方向
    @direct=5
    
    #用來放所有石頭的陣列
    @rocks=[]
    
    #用來放玩家子彈的陣列
    @bullets=[]
    #預設不在射擊狀態
    @shoot=false
    
    #初始分數0分
    @score=0
  end
  #每個畫格進行更新
  def update
    #取得已經觸發的事件
    case event=SDL.PollEvent
    when SDL::KeyboardEvent
      #按下了ESC就直接結束
      case event.type
      when SDL::KEYDOWN
        #判斷按下了哪個鍵
        case event.keysym.sym
        when SDL::K_UP     then @direct+=3
        when SDL::K_DOWN   then @direct-=3
        when SDL::K_LEFT   then @direct-=1
        when SDL::K_RIGHT  then @direct+=1
        #按下Z就轉為射擊狀態
        when SDL::K_z      then @shoot=true
        when SDL::K_ESCAPE then exit
        end
      when SDL::KEYUP
        #按鍵放開事情則相反
        case event.keysym.sym
        when SDL::K_UP    then @direct-=3
        when SDL::K_DOWN  then @direct+=3
        when SDL::K_LEFT  then @direct+=1
        when SDL::K_z     then @shoot=false
        when SDL::K_RIGHT then @direct-=1
        end
      end
    when SDL::QuitEvent
      #按下了右上角的關閉就直接結束
      exit
    end
    #更新玩家的船
    @ship.update(@direct)
    #假如在射擊狀態且玩家可射擊則把2顆子彈加入陣列
    @bullets<<Bullet.new(@ship,true)<<Bullet.new(@ship,false) if @shoot && @ship.shoot
    #每顆子彈更新
    @bullets.each(&:update)
    
    #有15%的機率產生新的石頭
    @rocks<<Rock.new if rand<0.15
    #每個石頭更新
    #? rocks每個rock要update
    
    #記錄目前的石頭數量
    origin_rock_count = @rocks.size
    #刪除螢幕外的石頭
    @rocks.reject!(&:over?)
    #增加分數為已經刪除的石頭數
    @score += origin_rock_count - @rocks.size
    
    #刪除在螢幕外的子彈
    @bullets.reject!(&:over?)
    
    #假如石頭碰到玩家則刪除石頭並對玩家造成傷害
    @rocks.reject!{|rock| rock.touch?(@ship) and @ship.damage }
    #檢查所有的石頭是否有碰到子彈並對石頭造成傷害
    @rocks.each{|rock| 
      @bullets.each{|bullet|
        rock.touch?(bullet) and rock.damage
      }
    }
    #刪除被打爆的石頭
    @rocks.keep_if(&:alive?)
    
    #在標題列顯示分數以及生命計量
    SDL.WM_SetCaption("Score:#{@score} HP:#{@ship.hp}","")
    
    #玩家太空船毀損則結束遊戲
    @end=true unless @ship.alive?
  end
  #繪圖
  def draw
    #繪製背景
    SDL.FillRect(@Screen,SDL::Rect.new([0,0,400,600]),0)
    #繪製玩家太空船
    @ship.draw(@Screen)
    #繪製石頭及子彈
    @rocks.each{|rock| rock.draw(@Screen)}
    @bullets.each{|bullet| bullet.draw(@Screen)}
    #顯示畫面
    SDL.Flip(@Screen)
  end
  #遊戲進入點
  def show
    #遊戲主迴圈 
    until(@end)
      #取得畫格開始時間
      t=SDL.GetTicks
      #更新
      update
      #繪製
      draw
      #取得補滿畫格所需時間
      time_to_sleep=16-(SDL.GetTicks-t)
      #補滿一畫格的16ms
      SDL.Delay (time_to_sleep>0)? time_to_sleep : 0
    end
    #檢查記錄檔是否存在並取得記錄
    record = File.open("Save.dat","rb"){|file| Marshal.load(file)} if File.exist?("save.dat") 
    #不存在則以0分計
    record ||= 0
    #高分記錄則顯示高分並將記錄寫入記錄檔
    if @score>record
      SDL.BlitSurface(SDL.LoadBMP("HighScore.bmp"),nil,@Screen,SDL::Rect.new([50,250,0,0]))
      File.open("Save.dat","wb"){|file| Marshal.dump(@score,file)}
    else
      SDL.BlitSurface(SDL.LoadBMP("GameOver.bmp"),nil,@Screen,SDL::Rect.new([50,250,0,0]))
    end
    #更新結束畫面
    SDL.Flip(@Screen)
    #3秒後自動結束
    SDL.Delay(3000)
  end
end
#遊戲初始化
game=Game.new
#遊戲開始
game.show