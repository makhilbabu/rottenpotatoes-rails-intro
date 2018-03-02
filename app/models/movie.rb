class Movie < ActiveRecord::Base
    def self.all_ratings
        new_array = Array.new
        self.select("rating").uniq.each {|x| new_array.push(x.rating)}
        new_array.sort.uniq()
    end
end
