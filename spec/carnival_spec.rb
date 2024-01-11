require 'spec_helper'

RSpec.describe Carnival do
    describe "#initialize" do
        it "exists as a carnival" do
            carnival1 = Carnival.new('Broomfield', "2 weeks")

            expect(carnival1).to be_a Carnival
        end
        
        it "has a duration" do
            carnival1 = Carnival.new('Broomfield', 14)

            expect(carnival1.duration).to eq(14)
        end
    end

    describe "#add_ride" do
        it "starts with no rides" do
            carnival1 = Carnival.new('Broomfield', 2)

            expect(carnival1.rides).to eq([])
        end
        it "add rides and can return an array of ride objects" do
            carnival1 = Carnival.new('Broomfield', 2)
            ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
            ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
            ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

            carnival1.add_ride(ride1)
            carnival1.add_ride(ride2)
            carnival1.add_ride(ride3)

            expect(carnival1.rides).to eq([ride1, ride2, ride3])
        end
    end

    describe "#most_popular_ride" do
        it "returns the most popular ride" do
            carnival1 = Carnival.new('Broomfield', 2)
            ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
            ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
            ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
            visitor1 = Visitor.new('Bruce', 54, '$10')
            visitor2 = Visitor.new('Tucker', 36, '$5')
            visitor3 = Visitor.new('Penny', 64, '$15')
            visitor1.add_preference(:gentle)
            visitor2.add_preference(:gentle)
            visitor2.add_preference(:thrilling)
            visitor3.add_preference(:thrilling)
            carnival1.add_ride(ride1)
            carnival1.add_ride(ride2)
            carnival1.add_ride(ride3)

            ride1.board_rider(visitor1)
            ride1.board_rider(visitor3)
            ride1.board_rider(visitor1)
            ride3.board_rider(visitor2)
            ride3.board_rider(visitor3)

            expect(carnival1.most_popular_ride).to eq(ride1)
        end
    end

    describe "#most_profitable_ride" do
        it "returns the most profitable ride" do
            carnival1 = Carnival.new('Broomfield', 2)
            ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
            ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
            ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
            visitor1 = Visitor.new('Bruce', 54, '$10')
            visitor2 = Visitor.new('Tucker', 36, '$5')
            visitor3 = Visitor.new('Penny', 64, '$15')
            visitor1.add_preference(:gentle)
            visitor2.add_preference(:gentle)
            visitor2.add_preference(:thrilling)
            visitor3.add_preference(:thrilling)
            carnival1.add_ride(ride1)
            carnival1.add_ride(ride2)
            carnival1.add_ride(ride3)

            ride1.board_rider(visitor1)
            ride1.board_rider(visitor3)
            ride1.board_rider(visitor1)
            ride2.board_rider(visitor1)
            ride3.board_rider(visitor2)
            ride3.board_rider(visitor3)

            expect(carnival1.most_profitable_ride).to eq(ride2)
        end
    end

    describe "#total_revenue" do
        it "returns correctly total revenue" do
            carnival1 = Carnival.new('Broomfield', 2)
            ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
            ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
            ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
            visitor1 = Visitor.new('Bruce', 54, '$10')
            visitor2 = Visitor.new('Tucker', 55, '$5')
            visitor3 = Visitor.new('Penny', 64, '$15')
            visitor1.add_preference(:gentle)
            visitor2.add_preference(:gentle)
            visitor2.add_preference(:thrilling)
            visitor3.add_preference(:gentle)
            visitor3.add_preference(:thrilling)
            carnival1.add_ride(ride1)
            carnival1.add_ride(ride2)
            carnival1.add_ride(ride3)

            ride1.board_rider(visitor1)
            ride1.board_rider(visitor3)
            ride1.board_rider(visitor1)
            ride2.board_rider(visitor1)
            ride3.board_rider(visitor2)
            ride3.board_rider(visitor3)

            expect(carnival1.total_revenue).to eq(12)
        end
    end

    describe "#summary" do
        it "returns accurate summary for the carnival" do
            carnival1 = Carnival.new('Broomfield', 2)
            ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
            ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
            ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
            visitor1 = Visitor.new('Bruce', 54, '$10')
            visitor2 = Visitor.new('Tucker', 55, '$5')
            visitor3 = Visitor.new('Penny', 64, '$15')
            visitor1.add_preference(:gentle)
            visitor2.add_preference(:gentle)
            visitor2.add_preference(:thrilling)
            visitor3.add_preference(:gentle)
            visitor3.add_preference(:thrilling)
            carnival1.add_ride(ride1)
            carnival1.add_ride(ride2)
            carnival1.add_ride(ride3)

            ride1.board_rider(visitor1)
            ride1.board_rider(visitor3)
            ride1.board_rider(visitor1)
            ride2.board_rider(visitor1)
            ride3.board_rider(visitor2)
            ride3.board_rider(visitor3)
require 'pry'; binding.pry
            expected = {
                visitor_count: 3,
                revenue_earned: 12,
                visitors: 
                [
                  { visitor: visitor1, favorite_ride: ride1, total_money_spent: 7 },
                  { visitor: visitor2, favorite_ride: ride3, total_money_spent: 2 },
                  { visitor: visitor3, favorite_ride: ride1, total_money_spent: 3 }
                ],
                rides: 
                [
                  { ride: ride1, riders: [visitor1, visitor3], total_revenue: 3 },
                  { ride: ride2, riders: [visitor1], total_revenue: 5 },
                  { ride: ride3, riders: [visitor2, visitor3], total_revenue: 4 }
                ]
              }

            expect(carnival1.summary).to eq(expected)

            # expect(carnival1.summary.class).to eq Hash
            # expect(carnival1.summary.keys).to eq([:visitor_count, :visitors, :revenue_earned, :rides])
            # expect(carnival1.summary[:visitor_count]).to eq(3)
            # expect(carnival1.summary[:revenue_earned]).to eq(12)
            # expect(carnival1.summary[:rides]).to eq([ride1.ride_summary, ride2.ride_summary, ride3.ride_summary])
            # expected = [
            #     {   visitor: visitor1, 
            #         favorite_ride: ride1, 
            #         total_money_spent: 7
            #     }, 
            #     {   visitor: visitor2, 
            #         favorite_ride: ride3, 
            #         total_money_spent: 2
            #     }, 
            #     {   visitor: visitor3, 
            #         favorite_ride: ride1, 
            #         total_money_spent: 3
            #     }
            # ]
            # expect(carnival1.summary[:visitors]).to eq(expected)
        end
    end
end
