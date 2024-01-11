class Carnival
    attr_reader :name,
                :duration,
                :rides

    def initialize(name, week_duration)
        @name = name
        @duration = week_duration
        @rides = []
    end

    def add_ride(ride)
        @rides << ride
    end

    def most_popular_ride
        @rides.max_by do |ride|
            ride.rider_log.values.sum
        end
    end

    def most_profitable_ride
        @rides.max_by do |ride|
            ride.total_revenue
        end
    end

    def total_revenue
        @rides.sum do |ride|
            ride.total_revenue
        end
    end

    def summary
        summary = {visitor_count:0, visitors: [],revenue_earned: total_revenue, rides: []}
        v = []
        @rides.each do |ride|
            summary[:rides] << ride.ride_summary
            require 'pry'; binding.pry
            ride.rider_log.each do |visitor, count|
                summary[:visitor_count] += 1 if !v.include?(visitor)
                
                summary[:visitors] << visitor.visitor_summary if !v.include?(visitor)

                v << visitor
            end
        end
        #require 'pry'; binding.pry
       summary
    end
end