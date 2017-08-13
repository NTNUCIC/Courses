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
#定義名為click的函式並傳入mouse_x和mouse_y
#提示: def
??
  #將輸入的滑鼠座標/100來算出九宮格的座標
  #提示:變數可命名為board_x,board_y
  ??
  #若$board的[board_y][board_x]有東西就回傳nil
  #提示:使用if決定要不要return
  ??
  
  #把棋子放入棋盤
  #提示:$board[board_y][board_x]和$side
  ??

  #取得獲勝方
  winner=check

  #雙方輪流
  #提示:若$side是:O就變成:X,反之:X變成:O
  ??
  
  #設定標題列提醒
  SDL.WM_SetCaption("現在輪到#{$side}下","")

  #回傳獲勝方
  return winner
end

#檢查某方是否獲勝
def check_one_side(side)
  #檢查橫向是否連線
  #提示:$board某一個橫列棋子都是side就獲勝
  #提示:any?和all?該如何使用
  ??

  #檢查縱向是否連線(利用矩陣轉置)
  #提示:transpose
  ??

  #檢查兩種斜向是否連線
  #提示:[0][0],[1][1],[2][2] 關鍵字:times, any?, all?
  ??
  #提示:[0][2],[1][1],[2][0] 關鍵字:times, any?, all?
  ??
end

#檢查何方獲勝
def check 
  #若是:O獲勝回傳:O,:X獲勝回傳:X
  #提示: check_one_side
  ??

  #平手回傳:draw
  #提示: 看看棋盤中是否還有nil
  ??
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