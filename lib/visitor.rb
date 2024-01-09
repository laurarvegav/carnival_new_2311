class Visitor
    attr_reader :name,
                :height,
                :preferences,
                :spending_money,
                :spent_money

    def initialize(name, height, spending_money)
        @name = name
        @height = height
        @spending_money = spending_money.gsub(/[^\d\.]/, '').to_i
        @preferences = []
        @spent_money = 0
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
end