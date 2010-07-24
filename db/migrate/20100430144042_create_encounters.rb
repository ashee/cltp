class CreateEncounters < ActiveRecord::Migration
  def self.up
    create_table :encounters do |t|
      t.string :pid
      t.string :age
      t.string :gender
      t.string :patient_type
      t.text :chief_complaint
      t.string :co_mobidity
      t.string :student
      t.string :academic_year
      t.string :period
      t.string :clerkship

      t.timestamps
    end
  end

  def self.down
    drop_table :encounters
  end
end
