class CreateHooplaUsers < ActiveRecord::Migration
  def change
    create_table :hoopla_users do |t|
      t.string :href
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
