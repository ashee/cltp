class Resource < ActiveRecord::Base
  has_many :resource_instances
  has_many :resource_votes
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
end
                