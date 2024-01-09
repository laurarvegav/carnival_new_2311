class Carnival
    attr_reader :name,
                :duration,
                :rides

    def initialize(name,week_duration)
        @name = name
        @duration = week_duration * 7
        @rides = []
    end

    def add_ride(ride)
        @rides << ride
    end

    def most_popular_ride
        @rides.max_by do |ride|
            ride.total_riders
        end
    end

    def most_profitable_ride
        @rides.max_by do |ride|
            ride.total_revenue
        end
    end

    def total_revenue
        revenue = 0
        @rides.each do |ride|
            revenue += ride.total_revenue
        end
        revenue
    end

    def summary
        summary = {}
        summary[:visitor_count] = 0
        summary[:visitors] = []
        summary[:revenue_earned] = total_revenue
        summary[:rides] = []
        
        @rides.each do |ride|
            summary[:visitor_count] += ride.rider_log.size
            
            summary[:rides] << ride.ride_summary
           
            ride.rider_log.keys.each do |rider|
                summary[:visitors] << rider.visitor_summary
            end
        end
        
       summary
    end
end