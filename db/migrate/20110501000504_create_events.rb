class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :email
      t.string :ip
      t.string :category
      t.string :action
      t.string :label
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
