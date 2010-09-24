class Diagnosis < ActiveRecord::Base
  set_table_name :dx
  belongs_to :clerkship
  belongs_to :category, :foreign_key => 'category_id', :class_name => 'DiagnosisCategory'
  has_many :encounter_diagnoses, :foreign_key => 'dx_id', :class_name => 'EncounterDiagnosis'
  
  def self.find_by_category_name(cat, name)
    sql = %q{
      select *
      from dx d join dx_categories c
      on d.category_id = c.id
      where c.name = ? and d.name = ?
    }
    self.find_by_sql(sql)
  end
  
  def self.dx_by_categories(clerkship_id)
    sql = %Q{
      select c.id as category_id, c.name as category_name, d.*
      from dx_categories c join dx d
      on c.id = d.category_id
      where c.clerkship_id = #{clerkship_id}
      order by c.name, d.name
    }
    self.find_by_sql sql
  end
  
end