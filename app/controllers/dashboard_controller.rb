class DashboardController < ApplicationController
  
  def index
    clerkship_id = Clerkship.find_by_name 'Pediatrics'
    @compliance_line1 = Compliance.status_by_user(@user.id, clerkship_id, 'O')
    @compliance_line2 = Compliance.status_by_user(@user.id, clerkship_id, 'P')

    
 
     
 #   for c in @compliance_line
#     logger.debug "***************#{c.clerkship.name}"
#      puts c.care_setting.name
#      puts c.hx_done
#      puts c.hx_required
#   end

   ## @compliance = Compliance.status()
   # loop over all the caresettings
   # grid = []
   # grid << Compliance.new(care_setting, 10, 5, 20, 5)

   respond_to do |format|
     format.html # index.html.erb
     format.xml  { render :xml => @encounters }
   end

  end
  
  def summary
  end
end
