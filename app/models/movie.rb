class Movie < ActiveRecord::Base
    def self.all_ratings
        new_array = self.uniq.pluck(:rating)
        new_array.sort.uniq()
    end
end
