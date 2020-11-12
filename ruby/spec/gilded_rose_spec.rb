require 'approvals/rspec'
require 'gilded_rose'

describe GildedRose do

  describe "Approvals Test" do
    it 'Output remains consistent' do
      verify do
        Dir.chdir(__dir__){
          `RUBYLIB="#{$:.join(':')}"; ruby texttest_fixture.rb`
        }
      end
    end
  end

end
