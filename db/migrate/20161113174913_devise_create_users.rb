class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      ## Profile
      t.string   :name
      t.string   :image

      t.timestamps null: false
    end
  end
end
