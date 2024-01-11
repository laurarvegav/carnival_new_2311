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
    end

    def board_rider(rider)
        if  meet_requirements?(rider)
            @rider_log[rider] += 1
            rider.ride(self)
            rider.spend_money(@admission_fee)
            @total_revenue += @admission_fee
        end
    end

    def meet_requirements?(rider)
        rider.tall_enough?(min_height) && 
        rider.preferences.include?(@excitement) && 
        rider.spending_money >= @admission_fee
    end

    def ride_summary
        {ride: self, riders: @rider_log.keys, total_revenue: @total_revenue}
    end
end