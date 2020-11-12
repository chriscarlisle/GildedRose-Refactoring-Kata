require 'approvals/rspec'
require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "Approvals Test" do
    it 'Output remains consistent' do
      verify do
        Dir.chdir(__dir__){
          `ruby texttest_fixture.rb`
        }
      end
    end
  end

end
