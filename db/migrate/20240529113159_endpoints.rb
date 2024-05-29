class Endpoints < ActiveRecord::Migration[7.0]
 def up
    create_table :endpoints do |t|
      t.string :path
      t.string :verb

      t.timestamps
    end
  end

  def down
    drop_table :endpoints
  end
end
