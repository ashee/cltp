class ReportsController < ApplicationController
  def index
  end
    
  def encounters_by_care_settings
    @reportlinearray = Reports.encounters_by_care_settings
    ActiveRecord::Base.logger.debug "@reportlinearray: #{@reportlinearray}"
    
  end

  def dx_by_students
     @reportarray = Reports.dx_by_students
  end
  
  def dx_by_students
      @reportarray = Reports.dx_by_students
   end
 
  def hnp_observed_vs_performed
     
  end
  
  def dx_observed_vs_performed
    @reportlinearray = Reports.dx_observed_vs_performed
  end
  
  def summary_dx_observed_vs_performed
  end

  def student_names
     # Need to populate the popup menu with all the users.
     # @userlist = User.all(:select => 'lastname, firstname', 'id')
   end
  
  def student_individual_dx
   end
  
end