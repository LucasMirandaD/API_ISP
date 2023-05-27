class CreateIsps < ActiveRecord::Migration[7.0]
  def change
    create_table :isps do |t|
      t.string :name_isp, unique: true
      t.string :password
      t.string :token, optional: true
      t.timestamps
    end
  end
end
