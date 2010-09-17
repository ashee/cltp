class DashboardController < ApplicationController
  
  def index
    clerkship_id = Clerkship.find_by_name 'Pediatrics'
    @compliances = Compliance.status_by_user(@user.id, clerkship_id)
    # @encounters = Com1pliance.status_by_user(@user.id)
   
    # @compliance = Compliance.new()
    # 
    # gridline1 = gridline2 = gridline3 = gridline4 = []
    # gridline1 << @compliance.inPatient
    # gridline2 << @compliance.outPatient
    # gridline3 << @compliance.newborn
   

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
