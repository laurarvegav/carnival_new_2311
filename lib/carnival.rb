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
end