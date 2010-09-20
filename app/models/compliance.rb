class Compliance < ActiveRecord::Base
  belongs_to :compliance_requirements
  
   
   def self.status_by_user(uid, clerkship_id, care_setting_id)
     sql = %Q{select count(*) as hx_done, cr.*, 0 as px_done
     from compliance_requirements cr 
     join care_settings cs on cr.care_setting_id = cs.id
     join clinics c on c.care_setting = cs.code
     join encounters e on e.clinic_id = c.id 
     where e.hx in ('P','B') and e.created_by = ? and e.clerkship_id = ? and c.care_setting = ?;
     }
     
     return ComplianceRequirement.find_by_sql [sql, uid, clerkship_id, care_setting_id]
   end

end


 # def self.required(care_setting, participation_type)
#    case care_setting.name
##      when 'Inpatient'
#        if participation_type == hx return 6 
#        if participation_type == px return 6
#      
##      when 'Outpatient'
#        if participation_type == hx return 30 
#        if participation_type == px return 30
#        
#      when 'Newborn'
#        if participation_type == hx return 4
#        if participation_type == px return 4
#    end
# 
#    def self.done(care_setting, participation_type)
#      case care_setting.name
#        when 'Inpatient'
#          if participation_type == hx return 7
#          if participation_type == px return 6
#
#        when 'Outpatient'
#          if participation_type == hx return 20
#          if participation_type == px return 20
#
#        when 'Newborn'
#          if participation_type == hx return 0
#          if participation_type == px return 2
#      end
 
 
    #   .....
    #   
    #   
    # Encounter.find_by_sql("select * from ")
#  end
  
#  def self.status(user)
    # client code looks like the following (in dashboard_controller)
    # Compliance.status()
    
    # prepares
    
#  end 
