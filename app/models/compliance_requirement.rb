class ComplianceRequirement < ActiveRecord::Base
  belongs_to :clerkship
  belongs_to :care_setting
  
  def hx_done
    read_attribute(:hx_done)
  end
  
  def px_done
    read_attribute(:px_done)
  end
  
end