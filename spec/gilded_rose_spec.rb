require File.join(File.dirname(__FILE__), '../lib/gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    context "Common items" do
      it "does not change the quality when quality = 0" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "sell_in value becomes negative" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
      end


      it "degrades the quality by one" do
        items = [Item.new("cockroach marshmallow", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 9
      end

      it "degrades the quality twice when sell_in == 0" do
        items = [Item.new("cockroach marshmallow", -1, 10)]
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -3
        expect(items[0].quality).to eq 6
      end

      it "degrades the quality twice when sell_in == 0 but quality cannot be negative" do
        items = [Item.new("cockroach marshmallow", -1, 2)]
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -3
        expect(items[0].quality).to eq 0
      end
    end

    context "Aged Brie" do
      it "quality increases every day" do
        items = [Item.new("Aged Brie", 5, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end

      it "quality increases every day" do
        items = [Item.new("Aged Brie", 5, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end

      it "quality increases twice every day when sell_in == 0" do
        items = [Item.new("Aged Brie", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end

      it "quality cannot be more than 50" do
        items = [Item.new("Aged Brie", 0, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "quality cannot be more than 50" do
        items = [Item.new("Aged Brie", -1, 49)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it "quality remains the same every day" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "sell_in remains the same every day" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 5
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert" do
      it "increases quality by two when sell_in < 10 days and >5" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 8, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end

      it "increases quality by two when sell_in < 10 days and > 5" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 8, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end

      it "increases quality by two when sell_in == 10 days " do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end

      it "increases quality by three when sell_in < 5 days and >0" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "increases quality by three when sell_in == 5 days" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "quality == 0  when sell_in < 0" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

    end

  end
end
