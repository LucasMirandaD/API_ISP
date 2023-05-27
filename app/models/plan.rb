class Plan < ApplicationRecord
    belongs_to :isp
    has_many :requests
end
