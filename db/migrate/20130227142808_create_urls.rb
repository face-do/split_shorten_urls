class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :access_token

      t.timestamps
    end
  end
end
