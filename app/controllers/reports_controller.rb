class ReportsController < ApplicationController
  def index
  end
    
  def encounters_by_care_settings
    @reportlinearray = Reports.encounters_by_care_settings
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
     @userlist = User.all
     ActiveRecord::Base.logger.debug "@userlist: #{@userlist}"
  end
  
  def student_individual_dx_select
      # Need to populate the popup menu with all the users.
      @students = User.students
   end
   
   def student_individual_dx
     student_id = params[:student_id]
     @items = Reports.student_individual_dx
     render :layout => false
   end
  
end