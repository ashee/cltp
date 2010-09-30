class User < ActiveRecord::Base
  has_many :user_rotations
  has_and_belongs_to_many :roles, :join_table => 'user_roles'  
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  
  def fullname
    "#{firstname} #{lastname}"
  end
  
  def academic_year
    @current_rotation = user_rotations.find(:last, :conditions => ['user_id = ? AND start_date <= now() AND end_date >= now()', self.id])
    @current_rotation.nil? ? "" : @current_rotation.academic_year
  end
  
  def current_period
    @current_rotation = user_rotations.find(:last, :conditions => ['user_id = ? AND start_date <= now() AND end_date >= now()', self.id])
    @current_rotation.nil? ? "" : @current_rotation.period
  end
  
  def current_clerkship
    @current_rotation = user_rotations.find(:last, :conditions => ['user_id = ? AND start_date <= now() AND end_date >= now()', self.id])
    @current_rotation.nil? ? "" : @current_rotation.clerkship.name
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
  
  def self.current_rotation(user_id)
    # lookup user_rotations for the given user_id where currrent date in between start_date and end_date
  end
  
end