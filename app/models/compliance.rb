class Compliance < ActiveRecord::Base
  belongs_to :compliance_requirements
  
   
   def self.status_by_user(uid, clerkship_id)
     sql = %Q{select cr.*,
     	(
     		select count(*) from encounters e join clinics c 
     		on e.clinic_id = c.id
     		join care_settings cs on c.care_setting = cs.code
     		where e.created_by = ? 
     		and e.clerkship_id = ?
     		and cs.id = cr.care_setting_id
     		and e.hx in ('P', 'B')
     	) as hx_done,
     	(
     		select count(*) from encounters e join clinics c 
     		on e.clinic_id = c.id
     		join care_settings cs on c.care_setting = cs.code
     		where e.created_by = ?
     		and e.clerkship_id = ?
     		and cs.id = cr.care_setting_id
     		and e.px in ('P', 'B')
     	) as px_done
     from compliance_requirements cr
     where cr.clerkship_id = ?;
     }

    return ComplianceRequirement.find_by_sql [sql,uid,clerkship_id,uid,clerkship_id,clerkship_id]
   end

end

