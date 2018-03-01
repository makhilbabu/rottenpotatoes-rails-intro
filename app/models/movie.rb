class Movie < ActiveRecord::Base
    def self.all_ratings
        new_array = Array.new
        new_array = Model.uniq.pluck(:rating)
        new_array.sort.uniq()
    end
end
