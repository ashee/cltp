class User < ActiveRecord::Base
  has_and_belongs_to_many :roles, :join_table => 'user_roles'  
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  
  def fullname
    "#{firstname} #{lastname}"
  end
  
  def academic_year
    #todo: remove hardcode below
    "Academic Year: 2010-2011"
  end
  
  def current_period
    #todo: remove hardcode below
    "Period: 1 (May 1-Jun 30)"
  end
  
  def current_clerkship
    #todo: remove hardcode below
    "Pediatrics"
  end
  
end