class ComplianceRequirement < ActiveRecord::Base
  belongs_to :clerkship
  belongs_to :care_setting
end