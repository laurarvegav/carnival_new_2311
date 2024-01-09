require 'spec_helper'

RSpec.describe Visitor do
    describe "#initialize" do
        it "exists as visitor intstance" do
            visitor1 = Visitor.new('Bruce', 54, '$10')

            expect(visitor1).to be_a Visitor
            expect(visitor1.name).to eq("Bruce")
            expect(visitor1.height).to eq(54)
            expect(visitor1.spending_money).to eq(10)
        end
    end

    describe "#add preference" do
        it "starts with no preferences" do
            visitor1 = Visitor.new('Bruce', 54, '$10')

            expect(visitor1.preferences).to eq([])
        end

        it "can add preferences correctly" do
            visitor1 = Visitor.new('Bruce', 54, '$10')
            visitor1.add_preference(:gentle)
            visitor1.add_preference(:thrilling)

            expect(visitor1.preferences).to eq([:gentle, :thrilling])
        end
    end

    describe "#tall_enough" do
        it "returns true when conditions met" do
            visitor1 = Visitor.new('Bruce', 54, '$10')
            visitor2 = Visitor.new('Tucker', 36, '$5')
            visitor3 = Visitor.new('Penny', 64, '$15')

            expect(visitor1.tall_enough?(54)).to be true
            expect(visitor2.tall_enough?(54)).to be false
            expect(visitor3.tall_enough?(54)).to be true
            expect(visitor1.tall_enough?(64)).to be false
        end
    end

    describe "#spend_money" do
        it "starts with 0 spent money" do
            visitor1 = Visitor.new('Bruce', 54, '$10')

            expect(visitor1.spent_money).to eq(0)
        end

        it "recalculates spending money after paying for a fee" do
            visitor1 = Visitor.new('Bruce', 54, '$10')
            visitor2 = Visitor.new('Tucker', 36, '$5')
            visitor3 = Visitor.new('Penny', 64, '$15')

            visitor1.spend_money(9)
            visitor2.spend_money(2)
            visitor3.spend_money(10)

            expect(visitor1.spending_money).to eq(1)
            expect(visitor2.spending_money).to eq(3)
            expect(visitor3.spending_money).to eq(5)

            expect(visitor1.spent_money).to eq(9)
            expect(visitor2.spent_money).to eq(2)
            expect(visitor3.spent_money).to eq(10)
        end
    end

    describe "#summary" do
        it "starts with no rides" do
            visitor1 = Visitor.new('Bruce', 54, '$10')

            expect(visitor1.rides).to eq({})
        end

        it "can add rides and accumulate # correctly" do
            visitor1 = Visitor.new('Bruce', 54, '$10')
            visitor1.ride('RollerCoaster')
            visitor1.ride('Train')
            visitor1.ride('RollerCoaster')

            expect(visitor1.rides).to eq({'RollerCoaster' => 2, 'Train' => 1})
        end

        it "can return complete summary" do
            visitor1 = Visitor.new('Bruce', 54, '$10')
            visitor1.ride('RollerCoaster')
            visitor1.ride('Train')
            visitor1.ride('RollerCoaster')
            visitor1.spend_money(9)
            
            expect(visitor1.visitor_summary).to eq({visitor: visitor1, total_money_spent: 9, favorite_ride: 'RollerCoaster'})
        end
    end
end