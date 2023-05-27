class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :name_plan
      t.belongs_to :isp, foreign_key: true
      t.string :band_width
      t.boolean :simetric
      t.timestamps
    end
  end
end
