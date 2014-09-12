# This module generates an alphabet of alpha-numeric characters for use in generating fake data.
module Trex
  module AlphaNum
    @symbols = ['!','@','#','$','%','^','&','*','(',')','-','+','=','<','>','?','~']
    def self.gen
      ('a'..'z').map{|aleph| aleph}
      .concat(('A'...'Z').map{|aleph2| aleph2})
      .concat(@symbols)
      .concat((1..20).map{|num| num})
    end

    #Some randomized date format generator.
    def self.date
      day = (1..31).map{|num| num}.sample
      month = (1..12).map{|num| num}.sample
      year2 = (10..99).map{|num| num}.sample
      year4 = (1900..2099).map{|n| n}.sample
      ["#{day}-#{month}-#{year2}",
      "#{day}/#{month}/#{year2}",
      "#{day}/#{month}/#{year4}",
      "#{day}-#{month}-#{year4}",
      "#{year4}-#{month}-#{day}",
      "#{year4}/#{month}/#{day}",
      "#{year2}/#{month}/#{day}",
      "#{year2}-#{month}-#{day}",
      "#{month}-#{day}-#{year2}",
      "#{month}/#{day}/#{year2}",
      "#{month}/#{day}/#{year4}",
      "#{month}-#{day}-#{year4}",
      "#{year4}-#{day}-#{month}",
      "#{year4}/#{day}/#{month}",
      "#{year2}/#{day}/#{month}",
      "#{year2}-#{day}-#{month}"].sample
    end
  end
end
