class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :address
      t.references :url, index: true
      t.integer :count, :default => 0

      t.timestamps
    end
  end
end
