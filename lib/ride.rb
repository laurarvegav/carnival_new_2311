class Ride 
    attr_reader :name,
                :min_height,
                :admission_fee,
                :excitement,
                :total_revenue,
                :rider_log,
                :total_riders
    
    def initialize(data)
        @name = data[:name]
        @min_height = data[:min_height]
        @admission_fee = data[:admission_fee]
        @excitement = data[:excitement]
        @total_revenue = 0
        @rider_log = Hash.new(0)
        @total_riders = 0
    end

    def board_rider(rider)
        if rider.tall_enough?(min_height) && 
            rider.preferences.include?(@excitement) &&
            rider.spending_money >= @admission_fee

            rider.ride(@name)
            @total_riders += 1
            @rider_log[rider] += @admission_fee
            rider.spend_money(@admission_fee)
            @total_revenue += @admission_fee
        end
    end

    def ride_summary
        summary = {}

        summary[:ride] = self
        summary[:riders] = @rider_log.keys
        summary[:total_revenue] = @total_revenue
        summary
    end

end