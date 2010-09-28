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
  
  def role_names
    roles.map {  r  r.name }.join(",")
  end
  
  def primary_role
    %w[Admin Clerkship Program Faculty Staff Student].detect { |rn|
      r = roles.detect {  |r|  r.name == rn }
    }
    
=begin
      # role_id in the db
      6	Admin
      3	Clerkship
      2	Faculty
      4	Program
      5	Staff
      1	Student
      
      # setup test data
      insert into user_roles (user_id,role_id) values (1, 1);
      insert into user_roles (user_id,role_id) values (1, 2);      
      insert into user_roles (user_id,role_id) values (1, 5);
=end
  end
  
  def self.students
    sql = %Q{
      select u.*
      from users u join user_roles ur
      on u.id = ur.user_id and ur.role_id = 1
    }
    
    self.find_by_sql sql
  end
  
end