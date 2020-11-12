# Factory for identifying and returning the category of an item
# Example:
#   category = ItemCategory.new.from_item('Aged Brie')
class ItemCategory

  def self.from_item(item)
    case item.name
    when 'Sulfuras, Hand of Ragnaros'
      LegendaryItem.new
    when 'Aged Brie'
      MaturedItem.new
    when 'Backstage passes to a TAFKAL80ETC concert'
      EventTicket.new
    when 'Conjured Mana Cake'
      ConjuredItem.new
    else
      NormalItem.new
    end
  end
end

# Once the sell by date has passed, Quality degrades twice as fast
# The Quality of an item is never negative
class NormalItem

  def age(item)
    if item.sell_in > 0
      item.quality = [0, item.quality - 1].max
    else
      item.quality = [0, item.quality - 2].max
    end

    item.sell_in -= 1
  end
end

# Matured Items increase in Quality the older they get
class MaturedItem

  def age(item)
    if item.sell_in > 0
      item.quality = [50, item.quality + 1].min
    else
      item.quality = [50, item.quality + 2].min
    end

    item.sell_in -= 1
  end

end

# Event Tickets, like Matured Items increases in Quality as its sell_in value approaches
# Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
# Quality drops to 0 after the concert
class EventTicket

  def age(item)
    if item.sell_in > 10
      item.quality = [50, item.quality + 1].min
    elsif item.sell_in > 5
      item.quality = [50, item.quality + 2].min
    elsif item.sell_in > 0
      item.quality = [50, item.quality + 3].min
    else
      item.quality = 0
    end

    item.sell_in -= 1
  end

end

# Legendary Items never have to be sold and don't decrease in Quality
class LegendaryItem

  def age(item)
  end

end

# Conjured Items degrade in Quality twice as fast as normal items
class ConjuredItem

  def age(item)
    if item.sell_in > 0
      item.quality = [0, item.quality - 2].max
    else
      item.quality = [0, item.quality - 4].max
    end

    item.sell_in -= 1
  end

end
