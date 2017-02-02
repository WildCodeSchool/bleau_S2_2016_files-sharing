class SharedWith < ApplicationRecord
    belongs_to :entity
    belongs_to :medium

    attr_accessor :selected

end