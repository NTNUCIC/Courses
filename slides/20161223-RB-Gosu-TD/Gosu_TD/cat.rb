#貓咪的基本類別
class Cat < Actor
  def initialize(type,hp,range,atk,spd)
    super("Cat#{type}.bmp",590,range,hp)
    @atk=atk
    @range=range
    @spd=spd
  end
  def update(list)
    super()
    #單體攻擊或移動
    target=detect(list)
    if target
      target.damage(@atk)
    else
      @x-=@spd
    end
  end
  #挑選一個可攻擊的目標
  def detect(arr)
    arr.each{|actor|
      actor.alive? and @x-@range<actor.x+actor.w/2 and return actor
    }
    return nil
  end
end
#小兵炮灰
class Kitten < Cat
  def initialize
    super("A",1200,60,2,1)
  end
end
#中堅鬥士
class SpearCat < Cat
  def initialize
    super("B",2400,120,5,0.6)
  end
end
#遠距輸出
class UFOCat < Cat
  def initialize
    super("C",1000,190,15,0.7)
  end
end
