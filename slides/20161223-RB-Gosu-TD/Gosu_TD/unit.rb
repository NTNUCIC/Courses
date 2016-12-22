#可以受到攻擊的基本類別
class Unit
  attr_reader :x,:w
  def initialize(path,x,hp)
    @img=Gosu::Image.new(path)
    @hp=hp
    @x=x
    @w=@img.width
    @draw_x=@x-@w/2
  end
  def update(*arg)
  end
  def damage(hp)
    @hp-=hp
  end
  def alive?
    @hp>0
  end
end