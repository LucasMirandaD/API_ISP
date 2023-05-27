class Request < ApplicationRecord
    belongs_to :isp, class_name: "Isp"
    belongs_to :client, class_name: "Client"
    belongs_to :plan, class_name: "Plan"
  end
  