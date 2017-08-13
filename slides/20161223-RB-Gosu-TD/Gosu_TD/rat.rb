#老鼠類別
class Rat < Actor
  def initialize
    super("Rat.bmp",50,185,2000)
  end
  def update(list)
    super()
    #取得攻擊範圍內所有單位
    targets=detect(list)
    unless targets.empty?
      #攻擊所有可攻擊單位
      targets.each{|target| target.damage(100) }
    else
      #不攻擊則移動
      @x+=0.5
    end
  end
  #取得處在攻擊範圍內的單位
  def detect(arr)
    arr.select{|actor|
      actor.alive? and actor.x<@x+@range
    }
  end
end
