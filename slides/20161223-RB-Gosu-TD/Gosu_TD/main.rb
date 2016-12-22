#!/usr/bin/ruby
#coding: utf-8

#引入Gosu函式庫
require 'gosu'
#引入該程式所需類別
require_relative 'unit'
require_relative 'actor'
require_relative 'tower'
require_relative 'cat'
require_relative 'rat'
#圖層區分
module ZOrder
  Background, Tower, Actor , UI = *0..4
end
#字體繪圖用單一實體類別
class Text
  #初始化
  def self.init
    @font=Gosu::Font.new(24)
  end
  #繪圖轉交
  def self.draw(*arg)
    @font.draw(*arg)
  end
end
#遊戲視窗類別
class Game < Gosu::Window
  #建構子
  def initialize
    super(640,320)
    #設定標題
    self.caption="Cats And Rats"
    #初始化字體繪圖功能
    Text.init
    #敵人單位佇列(包含敵方主塔)
    @enemy_queue=[Tower.new("TowerR.bmp",50,20000)]
    #我方單位佇列(包含我方主塔)
    @ally_queue=[Tower.new("TowerB.bmp",590,20000)]
    #背景地板色彩
    @ground=Gosu::Color.argb(0xff00ff00)
    #背景天空色彩
    @sky=Gosu::Color.argb(0xff00ffff)
    #太陽圖案
    @sun=Gosu::Image.new("Sun.bmp")
    #下此可再生產貓咪
    @cat_cd={
      Kitten => 0,
      SpearCat => 0,
      UFOCat => 0
    }
    #各種貓咪生產冷卻時間
    @cat_cold={
      Kitten => 480,
      SpearCat => 2400,
      UFOCat => 4200
    }
    #貓咪對應之按鍵
    @hotkey={
      Gosu::KbC => Kitten,
      Gosu::KbV => SpearCat,
      Gosu::KbB => UFOCat
    }
    #老鼠可以馬上生產
    @rat_cd=0
    #老鼠冷卻時間
    @rat_cold=3600
  end
  #每個畫格的更新
  def update
    #勝負決定後鎖定操作
    unless @winner
      #老鼠以一定間隔自動產生
      if @rat_cd<Gosu.milliseconds
        @enemy_queue<<Rat.new
        @rat_cd=Gosu.milliseconds+@rat_cold
      end
      #掃描各種貓咪對應按鍵並在可生產時產生貓咪
      @hotkey.each{|key,cat|
        if button_down?(key)&&@cat_cd[cat]<Gosu.milliseconds
          @ally_queue<<cat.new
          @cat_cd[cat]=Gosu.milliseconds+@cat_cold[cat]
        end
      }
    end
    #更新我方及敵方狀態
    @ally_queue.each{|ally| ally.update(@enemy_queue) }
    @enemy_queue.each{|enemy| enemy.update(@ally_queue) }
    #去除死亡單位
    @ally_queue.keep_if(&:alive?)
    @enemy_queue.keep_if(&:alive?)
    #勝負判定以及載入獲勝提示圖片
    @winner or @winner=check_winner and @hint=Gosu::Image.new("#{@winner}Wins.bmp")
  end
  #勝負判定
  def check_winner
    @ally_queue.empty? and return :Rat
    @enemy_queue.empty? and return :Cat
    @ally_queue.first.alive? or return :Rat
    @enemy_queue.first.alive? or return :Cat
    return nil
  end
  #繪圖函式
  def draw
    draw_quad(0,200,@ground,640,200,@ground,640,320,@ground,0,320,@ground,ZOrder::Background)
    draw_quad(0,0,@sky,640,0,@sky,640,200,@sky,0,200,@sky,ZOrder::Background)
    @sun.draw(500,20,ZOrder::Background)
    @enemy_queue.each &:draw
    @ally_queue.each &:draw
    #有獲勝提示才畫
    @hint&.draw(120,60,ZOrder::UI)
  end
end
game = Game.new
game.show