class CreateClerkships < ActiveRecord::Migration
  def self.up
    create_table :clerkships do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :clerkships
  end
end
