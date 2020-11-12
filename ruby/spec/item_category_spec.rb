require 'item_category'

def item_factory(name: 'Test Item', sell_in: 20, quality: 40)
  Item.new(name, sell_in, quality)
end

describe ItemCategory do

  describe '#from_item' do

    it 'Identifies Normal Items' do
      category = ItemCategory.from_item(item_factory(name: 'Flagon of Ale'))
      expect(category).to be_a NormalItem
    end

    it 'Identifies Matured Items' do
      category = ItemCategory.from_item(item_factory(name: 'Aged Brie'))
      expect(category).to be_a MaturedItem
    end

    it 'Identifies Legendary Items' do
      category = ItemCategory.from_item(item_factory(name: 'Sulfuras, Hand of Ragnaros'))
      expect(category).to be_a LegendaryItem
    end

    it 'Identifies Event Tickets' do
      category = ItemCategory.from_item(item_factory(name: 'Backstage passes to a TAFKAL80ETC concert'))
      expect(category).to be_a EventTicket
    end

  end

end

describe NormalItem do

  describe '#age' do

    it 'Reduces the sell by date by one' do
      NormalItem.new.age(item = item_factory(sell_in: 10))
      expect(item.sell_in).to eq(9)
    end

    it 'Reduces the quality by one before the sell by date has passed' do
      NormalItem.new.age(item = item_factory(sell_in: 1, quality: 10))
      expect(item.quality).to eq(9)
    end

    it 'Reduces the quality by two after the sell by date has passed' do
      NormalItem.new.age(item = item_factory(sell_in: 0, quality: 10))
      expect(item.quality).to eq(8)
    end

    it 'Wont reduce the quality beyond 0' do
      NormalItem.new.age(item = item_factory(quality: 0))
      expect(item.quality).to eq(0)
    end

  end

end

describe LegendaryItem do

  describe '#age' do

    it 'Doesnt reduce the sell by date' do
      LegendaryItem.new.age(item = item_factory(sell_in: 10))
      expect(item.sell_in).to eq(10)
    end

    it 'Doesnt degrade the quality' do
      LegendaryItem.new.age(item = item_factory(quality: 80))
      expect(item.quality).to eq(80)
    end

  end

end

describe MaturedItem do

  describe '#age' do

    it 'Reduces the sell by date by one' do
      MaturedItem.new.age(item = item_factory(sell_in: 10))
      expect(item.sell_in).to eq(9)
    end

    it 'Increases the quality by one before the sell by date has passed' do
      MaturedItem.new.age(item = item_factory(sell_in: 1, quality: 10))
      expect(item.quality).to eq(11)
    end

    it 'Increases the quality by two after the sell by date has passed' do
      MaturedItem.new.age(item = item_factory(sell_in: 0, quality: 10))
      expect(item.quality).to eq(12)
    end

    it 'Wont increase the quality beyond 50' do
      MaturedItem.new.age(item = item_factory(quality: 50))
      expect(item.quality).to eq(50)
    end

  end

end

describe EventTicket do

  describe '#age' do

    it 'Reduces the sell by date by one' do
      EventTicket.new.age(item = item_factory(sell_in: 10))
      expect(item.sell_in).to eq(9)
    end

    it 'Increases the quality by one for events that are more than 10 days away' do
      EventTicket.new.age(item = item_factory(sell_in: 11, quality: 10))
      expect(item.quality).to eq(11)
    end

    it 'Increases the quality by two for events that are between 6 and 10 days away' do
      EventTicket.new.age(item = item_factory(sell_in: 10, quality: 10))
      expect(item.quality).to eq(12)

      EventTicket.new.age(item = item_factory(sell_in: 6, quality: 10))
      expect(item.quality).to eq(12)
    end

    it 'Increases the quality by three for events that are less than 6 days away' do
      EventTicket.new.age(item = item_factory(sell_in: 5, quality: 10))
      expect(item.quality).to eq(13)
    end

    it 'Reduces the quality to zero after the event' do
      EventTicket.new.age(item = item_factory(sell_in: 0, quality: 10))
      expect(item.quality).to eq(0)
    end

  end

end
