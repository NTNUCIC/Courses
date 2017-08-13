#塔類別
class Tower < Unit
  def initialize(path,x,hp)
    super
    @draw_y=110
  end
  def draw
    #血量提示
    Text.draw(str=("%d"% @hp),@x-str.size*6,90,ZOrder::UI,1,1,Gosu::Color::BLACK)
    @img.draw(@draw_x,@draw_y,ZOrder::Tower)
  end
end
