class CreateHooplaMetrics < ActiveRecord::Migration
  def change
    create_table :hoopla_metrics do |t|
      t.string :href
      t.string :name

      t.timestamps null: false
    end
  end
end
