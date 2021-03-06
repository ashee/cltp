class ComplianceRequirement < ActiveRecord::Base
  belongs_to :clerkship
  belongs_to :care_setting
  
  def hx_done
    self[:hx_done].to_i
  end
  
  def hx_diff
    hx_done - hx_required
  end
  
  def px_done
    self[:px_done].to_i
  end
  
  def px_diff
    px_done - px_required
  end
end