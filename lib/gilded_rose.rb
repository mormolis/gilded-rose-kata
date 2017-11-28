class GildedRose

  SPECIAL_ITEMS = ["Sulfuras, Hand of Ragnaros","Aged Brie","Backstage passes to a TAFKAL80ETC concert", "Conjured"]
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update_common_item(item) if !SPECIAL_ITEMS.include?(item.name)
      update_aged_brie(item) if item.name == SPECIAL_ITEMS[1]
      update_backstage_passes(item) if item.name == SPECIAL_ITEMS[2]
      update_conjured(item) if item.name == SPECIAL_ITEMS[3]
    end  
  end

  private
  def update_common_item(item)
    if has_not_expired?(item) && item.quality > MIN_QUALITY 
      item.quality -= 1
    elsif has_expired?(item) && item.quality > MIN_QUALITY
      item.quality -= 2
    end
    item.sell_in -= 1
  end

  def update_aged_brie(item)
    item.quality += 1 if has_expired?(item) && item.quality < MAX_QUALITY
    item.quality += 1 if item.quality < MAX_QUALITY
    item.sell_in -= 1
  end

  def update_backstage_passes(item)
    item.quality = MIN_QUALITY if has_expired?(item)
    item.quality += 1 if item.sell_in > 10 || (item.sell_in <= 5 && has_not_expired?(item))
    item.quality += 2 if item.sell_in <= 10 && has_not_expired?(item)
    item.sell_in -= 1
  end

  def update_conjured(item)
    update_common_item(item)
    item.sell_in += 1
    update_common_item(item)
  end

  def has_expired?(item)
    item.sell_in <= 0
  end

  def has_not_expired?(item)
    item.sell_in > 0
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