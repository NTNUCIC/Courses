#可活動單位類別
class Actor < Unit
  def initialize(path,x,range,hp)
    super(path,x,hp)
    @h=@img.height
    @y=0
    #加上一個隨機的偏移量讓圖片不要完全重疊
    @offset=rand(20)
    @range=range
  end
  def update
    @draw_x=@x-@w/2
    @draw_y=250-@h-@offset
  end
  def draw
    #繪圖額外以遠近來排序
    @img.draw(@draw_x,@draw_y,ZOrder::Actor-@offset*0.05)
  end
end
