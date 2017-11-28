class GildedRose

  SPECIAL_ITEMS = ["Sulfuras, Hand of Ragnaros","Aged Brie","Backstage passes to a TAFKAL80ETC concert"]

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update_common_item(item) if !SPECIAL_ITEMS.include?(item.name)
        
      

    end
      
  end

  def update_common_item(item)
    if item.sell_in > 0 && item.quality > 0 
      item.quality -= 1
    elsif item.sell_in <= 0 && item.quality > 0
      item.quality -= 2
    end
    item.sell_in -= 1
  end



end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end