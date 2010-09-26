class Resource < ActiveRecord::Base
  has_many :resource_instances
  has_many :resource_votes
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  
  def self.find_by_encounter(encounter_id)
    sql = <<-EOF
      select * from resource_instances ri
      join resources r on r.id = ri.resource_id
      where ri.tag = 'encounters' and ri.tag_id = ?
    EOF
    
    ResourceInstance.find_by_sql [sql, encounter_id]
  end
  
  def self.find_related_by_encounter(encounter_id)
    sql = <<-EOF
      select r.*, ri.*
      from encounters e 
      join encounter_dx ed on e.id = ed.encounter_id
      join resource_instances ri on ri.tag = 'dx' and ri.tag_id = ed.dx_id
      join resources r on ri.resource_id = r.id
      where e.id = ?
    EOF
    
    ResourceInstance.find_by_sql [sql, encounter_id]
  end
  
  def self.find_by_tag(tag,tag_ids)
    ResourceInstance.find :all, :conditions => ["tag = ? and tag_id in (?)", tag, tag_ids], :include => :resource
  end
  
end
