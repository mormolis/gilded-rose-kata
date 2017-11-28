class GildedRose

  SPECIAL_ITEMS = ["Sulfuras, Hand of Ragnaros","Aged Brie","Backstage passes to a TAFKAL80ETC concert", "Conjured"]
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  BACKSTAGE_PASSES_VALUED_DAYS_MAX = 10
  BACKSTAGE_PASSES_VALUED_DAYS_MIN = 5

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
      decrease_quality_by(item, 1)
    elsif has_expired?(item) && item.quality > MIN_QUALITY
      decrease_quality_by(item, 2)
    end
    a_day_passes(item)
  end

  def update_aged_brie(item)
    increase_quality_by(item, 1) if has_expired?(item) && item.quality < MAX_QUALITY
    increase_quality_by(item, 1) if item.quality < MAX_QUALITY
    a_day_passes(item)
  end

  def update_backstage_passes(item)
    item.quality = MIN_QUALITY if has_expired?(item)
    increase_quality_by(item, 1) if more_than_ten_days_or_five_or_less_and_not_expired(item)
    increase_quality_by(item, 2) if item.sell_in <= BACKSTAGE_PASSES_VALUED_DAYS_MAX && has_not_expired?(item)
    a_day_passes(item)
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

  def more_than_ten_days_or_five_or_less_and_not_expired(item)
    item.sell_in > BACKSTAGE_PASSES_VALUED_DAYS_MAX || (item.sell_in <= BACKSTAGE_PASSES_VALUED_DAYS_MIN && has_not_expired?(item))
  end

  def increase_quality_by(item, quality)
    item.quality += quality
  end

  def decrease_quality_by(item, quality)
    item.quality -= quality
  end

  def a_day_passes(item)
    item.sell_in -= 1
  end
  
end
