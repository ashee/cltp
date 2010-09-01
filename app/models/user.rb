class User < ActiveRecord::Base
  has_and_belongs_to_many :roles, :join_table => 'user_roles'  
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
end