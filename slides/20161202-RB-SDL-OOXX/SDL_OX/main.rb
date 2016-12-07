#!/usr/bin/ruby
#coding: utf-8

#一定要引入SDL函式庫
require 'ruby-sdl-ffi'

#初始化SDL的繪圖功能
SDL.Init(SDL::INIT_VIDEO)

#取得螢幕300x300
$Screen=SDL.SetVideoMode(300,300,32,SDL::SWSURFACE)

#設定先手方
$side=:X
SDL.WM_SetCaption("現在輪到#{$side}下","")

#載入棋子圖檔
$Chess={
  O: SDL.LoadBMP("O.bmp"),
  X: SDL.LoadBMP("X.bmp")
}
#以圖形左上角像素設定透明背景
$Chess.each_value{|pic| SDL.SetColorKey(pic,SDL::SRCCOLORKEY,0x00FF00FF) }

#以列為主的棋盤
$board=Array.new(3){ Array.new(3){ nil } }

#點擊滑鼠後的處理函式
def click(mouse_x,mouse_y)
  #若該位置已經有棋子就當作沒事
  board_x=mouse_x/100
  board_y=mouse_y/100
  return nil if $board[board_y][board_x]
  
  #把棋子放入棋盤
  $board[board_y][board_x]=$side

  #取得獲勝方
  winner=check

  #雙方輪流
  if $side==:O
    $side=:X
  else
    $side=:O
  end
  #設定標題列提醒
  SDL.WM_SetCaption("現在輪到#{$side}下","")

  #回傳獲勝方
  return winner
end

#檢查某方是否獲勝
def check_one_side(side)
  #檢查橫向是否連線
  $board.any?{|row| row.all?{|chess| chess==side } } or
  #檢查縱向是否連線(利用矩陣轉置)
  $board.transpose.any?{|col| col.all?{|chess| chess==side } } or 
  #檢查兩種斜向是否連線
  3.times.all?{|i| $board[i][i]==side } or
  3.times.all?{|i| $board[i][2-i]==side }
end

#檢查何方獲勝
def check 
  return :O if check_one_side(:O)
  return :X if check_one_side(:X)
  #假如棋盤中沒有nil就不能下了
  return :draw if $board.flatten.compact.size==9
end

#繪製背景
def draw_background
  #填滿背景顏色
  SDL.FillRect($Screen,SDL::Rect.new([0,0,300,300]),0x00FFFFFF)

  #把井字畫出來
  SDL.FillRect($Screen,SDL::Rect.new([10,100,280,1]),0)
  SDL.FillRect($Screen,SDL::Rect.new([10,200,280,1]),0)
  SDL.FillRect($Screen,SDL::Rect.new([100,10,1,280]),0)
  SDL.FillRect($Screen,SDL::Rect.new([200,10,1,280]),0)
end

#重複運行直到取得結果
winner=nil
until(winner)
  #判斷觸發了何種事件
  case event=SDL.PollEvent
  when SDL::KeyboardEvent
    #按下了ESC就直接結束
    case event.keysym.sym
    when SDL::K_ESCAPE
      exit
    end
  when SDL::MouseButtonEvent
    #只判斷按下滑鼠左鍵的狀況
    case event.button
    when SDL::BUTTON_LEFT
      winner=click(event.x,event.y)
    end
  when SDL::QuitEvent
    #按下了右上角的關閉就直接結束
    exit
  end

  #先畫背景
  draw_background
  #把每顆棋子畫出來
  $board.each_with_index{|row,y|
    row.each_with_index{|chess,x|
      #只有有棋子才需要畫
      $Chess[chess] and 
	  SDL.BlitSurface($Chess[chess],nil,$Screen,SDL::Rect.new([x*100,y*100,0,0]))
    }
  }

  #把畫圖的結果顯示在螢幕上
  SDL.Flip($Screen)
  #讓CPU短暫休息
  SDL.Delay(16)
end

#判斷是否單方面獲勝並在螢幕上以及標題列顯示獲勝訊息
if winner==:X||winner==:O
  SDL.WM_SetCaption("#{winner}獲勝,遊戲結束","")
  SDL.BlitSurface(SDL::LoadBMP("#{winner}_Wins.bmp"),nil,$Screen,SDL::Rect.new([0,100,0,0]))
  #$Screen.put(SDL::Surface.load(),0,100)
else
  SDL.WM_SetCaption("平手,遊戲結束","")
  SDL.BlitSurface(SDL::LoadBMP("Draw.bmp"),nil,$Screen,SDL::Rect.new([0,100,0,0]))
end
#顯示更新的畫面
SDL.Flip($Screen)
#顯示5秒後自動關閉
SDL.Delay(5000)