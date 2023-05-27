class Client < ApplicationRecord
    validates :nickname, uniqueness: true, presence: true
    has_many :requests
    before_create :set_token

    def set_token
        self.token=SecureRandom.uuid
    end
end 