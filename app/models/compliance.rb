class Compliance < ActiveRecord::Base
  belongs_to :compliance_requirements
  
   
   def self.status_by_user(uid, clerkship_id, care_setting_id)
=begin
     sql = %Q{select count(*) as hx_done, cr.*, 0 as px_done
     from compliance_requirements cr 
     join care_settings cs on cr.care_setting_id = cs.id
     join clinics c on c.care_setting = cs.code
     join encounters e on e.clinic_id = c.id 
     where e.hx in ('P','B') and e.created_by = ? and e.clerkship_id = ? and c.care_setting = ?;
     }
=end

    sql = %Q{select *, 5 as hx_done, 6 as px_done, 
                    (5 - hx_required) as hx_diff, 
                    (6 - px_required) as px_diff
            from compliance_requirements
    }
     
    return ComplianceRequirement.find_by_sql [sql, uid, clerkship_id, care_setting_id]
   end

end

