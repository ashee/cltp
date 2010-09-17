class CareSetting < ActiveRecord::Base
  has_many :compliance_requirements
end