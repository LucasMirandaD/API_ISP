class Isp < ApplicationRecord
    validates :name_isp, uniqueness: true, presence: true
    has_many :requests
    has_many :plans
    before_create :set_token


    def set_token
        self.token=SecureRandom.uuid
    end
end 
