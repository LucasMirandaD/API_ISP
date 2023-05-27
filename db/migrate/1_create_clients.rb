class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :nickname, unique: true
      t.string :password
      t.string :token, optional: true
      t.timestamps
    end
  end
end
