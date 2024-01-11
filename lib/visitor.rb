class Visitor
    attr_reader :name,
                :height,
                :preferences,
                :spending_money,
                :spent_money,
                :rides

    def initialize(name, height, spending_money)
        @name = name
        @height = height
        @spending_money = spending_money.delete('$').to_i
        @preferences = []
        @spent_money = 0
        @rides = Hash.new(0)
    end

    def add_preference(preference)
        @preferences << preference
    end

    def tall_enough?(height)
        height <= @height
    end

    def spend_money(fee)
        @spending_money -= fee
        @spent_money += fee
    end

    def ride(ride)
        @rides[ride] += 1
    end

    def visitor_summary
        summary = {}
        summary[:visitor] = self
        summary[:total_money_spent] = @spent_money
        summary[:favorite_ride] = @rides.key(@rides.values.max)
        summary
    end
end