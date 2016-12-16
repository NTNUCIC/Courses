#!/usr/bin/ruby
#coding: utf-8

#引入SDL函式庫
require 'ruby-sdl-ffi'
#紅色棋子的類別
class RedChess
  attr_reader :location
  #設定初始棋子的亂數位置
  @@init_location=[1,2,3,6,7,11].shuffle!
  #起始棋子編號為1
  @@init_count=1
  #內建初始化狀態的建構子
  def initialize
    #循序產生棋子
    @id=@@init_count
    @pic=SDL.LoadBMP("R#{@id}.bmp")
    SDL.SetColorKey(@pic,SDL::SRCCOLORKEY,0x00FF00FF)
    #取得一個隨機位置
    @location=@@init_location.pop
    #增加棋子編號
    @@init_count+=1
    #將棋盤位置
    @x=(@location-1)%5
    @y=(@location-1)/5
  end
  #繪圖用方法
  def draw(screen)
    SDL.BlitSurface(@pic,nil,screen,SDL::Rect.new([@x*100,@y*100,0,0]))
  end
  #檢查並移動棋子
  def move(direct)
    #不可移動則回傳nil
    result = case direct
    #可以則向右走
    when 6 then @x<4 and @location+=1
    #可以則向下走
    when 2 then @y<4 and @location+=5
    #可以則往右下走
    when 3 then (@x<4&&@y<4) and @location+=6
    end
    #重新計算座標
    @x=(@location-1)%5
    @y=(@location-1)/5
    #回傳結果
    result
  end
  #辨識編號用
  def to_i
    @id
  end
  #在除錯時方便顯示資料
  def inspect
    "<R#{@id} @#{@location}=[#{@x},#{@y}]>"
  end
end
#藍色棋子的類別
class BlueChess
  attr_reader :location
  @@init_location=[15,19,20,23,24,25].shuffle!
  @@init_count=1
  def initialize
    @id=@@init_count
    #?here? 載入B的貼圖
    :here
    #?here? 設定背景色
    :here
    
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
    #可以則向左走
    when 4 then @x>0 and @location-=1
    #可以則向上走
    when 8 then @y>0 and @location-=5
    #可以則向左上走
    when 7 then (@x>0&&@y>0) and @location-=6
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
#遊戲主控單一實體類別
class Game
  #定義常數
  @@RED=0
  @@BLUE=10
  #初始化用(代替建構子)
  def self.init
    #初始化顯示視窗
    SDL.Init(SDL::INIT_VIDEO)
    @Screen=SDL.SetVideoMode(500,500,32,SDL::SWSURFACE)
    #建立棋子的列表
    @chesses=Array.new(12){|i|
      #列表前半為紅色後半為藍色
      (i<6) ? RedChess.new : BlueChess.new
    }
    @turn=0
    #一開始為藍色先手
    round_start
  end
  #回合開始的處理
  def self.round_start
    #兩方輪流
    @turn=10-@turn
    #狀態可能為移動或選擇
    @state=:move
    @dice=rand(6)+1
    #假如沒有骰到存在的棋子則進入選擇模式
    unless @chesses.any?{|chess| chess.to_i==@dice+@turn}
      @state=:select
      #假如選擇只有一種自動選好
      if dice=(single||side_single)
        @dice=dice
        @state=:move
      end
    end
    #設定標題作為提示
    SDL.WM_SetCaption("#{(@turn==@@RED)?"RED":"BLUE"} can #{@state} #{@dice}","")
  end
  #取得盤面剩下的一顆棋或沒事
  def self.single
    #取得該方的棋子列表
    case @turn
    when @@RED
      domain=@chesses[0...6]
    when @@BLUE
      domain=@chesses[6...12]
    end
    #剩下一顆棋則取出該棋子對應的骰子點數
    domain.compact.size==1 and domain[domain.index{|e| !e.nil?}].to_i-@turn
  end
  #取得唯一一種選擇或不選擇
  def self.side_single
    left=right=nil
    #分別取得棋子左右兩邊的列表
    case @turn
    when @@RED
      left=@chesses[0...@dice].compact
      right=@chesses[@dice...6].compact
    when @@BLUE
      left=@chesses[6...6+@dice].compact
      right=@chesses[6+@dice...12].compact
    end
    #一方為空則選另一方最接近的棋子並取得其對應骰點
    if left.empty? then right.first.to_i-@turn
    elsif right.empty? then left.last.to_i-@turn
    end
  end
  #檢查並選擇以某顆棋來移動
  def self.select?(dice)
    left=right=nil
    case @turn
    when @@RED
      left=@chesses[0...@dice]
      right=@chesses[@dice...6]
    when @@BLUE
      left=@chesses[6...6+@dice]
      right=@chesses[6+@dice...12]
    end
    #只能選編號最接近該空位的兩個棋子之一
    left.compact.last.to_i==dice+@turn or 
    right.compact.first.to_i==dice+@turn
  end
  #根據棋子移動結果移動或不移動該棋子
  def self.move(dice,direct)
    #選擇要移動的棋子
    chess=@chesses.select{|c| c.to_i==dice+@turn}[0]
    #得到移動目標或是不移動
    target=chess.move(direct)
    #看看使否吃棋或不吃棋
    @chesses.map!{|c|
      if c&.location==target&&c!=chess then nil
      else c
      end
    }
    #回傳結果
    target
  end
  #每個畫格更新用
  def self.update
    case event=SDL.PollEvent
    when SDL::KeyboardEvent
      #僅有按下按鍵才動作
      event.type==SDL::KEYDOWN and 
      case @state
      #挑選要以棋子中何者移動
      when :select
        case sym=event.keysym.sym
        #利用數字鍵輸入棋子編號
        when SDL::K_KP1..SDL::K_KP6
          #取得棋子編號
          dice=sym-SDL::K_KP0
          #假如可以選擇
          if select?(dice)
            #選擇該棋子並進入移動模式
            @state=:move
            @dice=dice
            SDL.WM_SetCaption("#{(@turn==@@RED)? "RED":"BLUE"} can move #{@dice}","")
          end
        when SDL::K_ESCAPE
          exit
        end
      when :move
        #利用數字鍵當成方向鍵來移動棋子
        #紅方可以向右、下和右下來移動
        #藍方可以向左、上和左上來移動
        case sym=event.keysym.sym
        when SDL::K_KP7,SDL::K_KP8,SDL::K_KP4,SDL::K_KP6,SDL::K_KP3,SDL::K_KP2
          direct=sym-SDL::K_KP0
          #可以移動則移動並開始新回合
          move(@dice,direct) and round_start
        when SDL::K_ESCAPE
          exit
        end
      end
    when SDL::QuitEvent
      exit
    end
    #檢查獲勝方
    @winner=check_winner
  end
  #繪製背景
  def self.draw_background
    #填滿背景
    SDL.FillRect(@Screen,SDL::Rect.new([0,0,500,500]),0x00FFFFFF)
    #繪製格線
    4.times{|i|
      #畫質線
      SDL.FillRect(@Screen,SDL::Rect.new([100*(i+1),0,1,500]),0)
      #?here? 參考上方方法畫橫線
      :here
    }
  end
  #檢查獲勝方
  def self.check_winner
    #被吃光則對方獲勝
    @chesses[0...6].compact.empty? and return @@BLUE
    #?here? 若是[6...12]裏面都是nil則回傳@@RED
    :here
    #走到終點則獲勝
    @chesses.any?{|c| c&.location==25&&c.instance_of?(RedChess)} and return @@RED
    @chesses.any?{|c| c&.location==1&&c.instance_of?(BlueChess)} and return @@BLUE
  end
  def self.draw
    draw_background
    @chesses.each{|chess| chess&.draw(@Screen)}
    SDL.Flip(@Screen)
  end
  #結束處理
  def self.finish
    #繪製獲勝提示
    SDL.BlitSurface(SDL::LoadBMP("#{(@winner==@@RED)?"R":"B"}Win.bmp"),nil,@Screen,SDL::Rect.new([50,180,0,0]))
    SDL.Flip(@Screen)
    #設定標題提示獲勝方
    SDL.WM_SetCaption("#{(@winner==@@RED)?"RED":"BLUE"} wins","")
    #3秒鐘後自動關閉
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