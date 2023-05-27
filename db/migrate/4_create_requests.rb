class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :numberRequest
      t.boolean :acceptRequest
      t.belongs_to :client, foreign_key: true
      t.belongs_to :plan, foreign_key: true
      t.belongs_to :isp, foreign_key: true
      t.timestamps
    end
  end
end
