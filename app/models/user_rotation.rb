class UserRotation < ActiveRecord::Base
  belongs_to :user
  belongs_to :clerkship
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
end