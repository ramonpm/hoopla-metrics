class CreateHooplaMetricValues < ActiveRecord::Migration
  def change
    create_table :hoopla_metric_values do |t|
      t.string :href
      t.references :metric, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.decimal :value

      t.timestamps null: false
    end
  end
end
