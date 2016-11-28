#!/usr/bin/ruby
#coding: utf-8

#一定要引入SDL函式庫
require 'sdl'

#初始化SDL的繪圖功能
SDL.init(SDL::INIT_VIDEO)

#取得螢幕300x300
$Screen=SDL::Screen.open(300,300,32,SDL::SWSURFACE)

#設定先手方
$side=:X
SDL::WM.set_caption("現在輪到#{$side}下","")

#載入棋子圖檔
$Chess={
  O: SDL::Surface.load("O.bmp"),
  X: SDL::Surface.load("X.bmp")
}
#以圖形左上角像素設定透明背景
$Chess.each_value{|pic| pic.set_color_key(SDL::SRCCOLORKEY,pic[0,0]) }

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
  SDL::WM.set_caption("現在輪到#{$side}下","")

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
  $Screen.fill_rect(0,0,300,300,[255,255,255])

  #把井字畫出來
  $Screen.draw_line(10,100,290,100,[0,0,0])
  $Screen.draw_line(10,200,290,200,[0,0,0])
  $Screen.draw_line(100,10,100,290,[0,0,0])
  $Screen.draw_line(200,10,200,290,[0,0,0])
end

#重複運行直到取得結果
winner=nil
until(winner)
  #判斷觸發了何種事件
  case event=SDL::Event.poll
  when SDL::Event::KeyDown
    #按下了ESC就直接結束
    case event.sym
    when SDL::Key::ESCAPE
      exit
    end
  when SDL::Event::MouseButtonDown
    #只判斷按下滑鼠左鍵的狀況
    case event.button
    when SDL::Mouse::BUTTON_LEFT
      winner=click(event.x,event.y)
    end
  when SDL::Event::Quit
    #按下了右上角的關閉就直接結束
    exit
  end

  #先畫背景
  draw_background
  #把每顆棋子畫出來
  $board.each_with_index{|row,y|
    row.each_with_index{|chess,x|
      #只有有棋子才需要畫
      $Chess[chess] and $Screen.put($Chess[chess],x*100,y*100)
    }
  }

  #把畫圖的結果顯示在螢幕上
  $Screen.flip
  #讓CPU短暫休息
  SDL.delay(16)
end

#判斷是否單方面獲勝並在螢幕上以及標題列顯示獲勝訊息
if winner==:X||winner==:O
  SDL::WM.set_caption("#{winner}獲勝,遊戲結束","")
  $Screen.put(SDL::Surface.load("#{winner}_Wins.bmp"),0,100)
else
  SDL::WM.set_caption("平手,遊戲結束","")
  $Screen.put(SDL::Surface.load("Draw.bmp"),0,100)
end
#顯示更新的畫面
$Screen.flip
#顯示5秒後自動關閉
SDL.delay(5000)