class DashboardController < ApplicationController
  
  def index
    if @user.primary_role != "Student"
      render :file => "public/401.html", :status => :unauthorized 
      return
    end

   clerkship_id = Clerkship.find_by_name 'Pediatrics'
   @statuses = Compliance.status_by_user(@user.id, clerkship_id)
   
   @hx_total, @px_total, @hx_required_total, @px_required_total, @hx_diff_total, @px_diff_total = 0, 0, 0, 0, 0, 0
   
   @statuses.each do |s|
     @hx_total += s.hx_done
     @px_total += s.px_done
     @hx_required_total += s.hx_required
     @px_required_total += s.px_required
     @hx_diff_total += s.hx_done - s.hx_required
     @px_diff_total += s.px_done - s.px_required
   end

   @current_clerkship = @user.current_clerkship
   ActiveRecord::Base.logger.debug "===================== @user: #{@user}"
   ActiveRecord::Base.logger.debug "===================== @user.current_clerkship: #{ @user.current_clerkship}"
   # get data for the problems table
   @problems = Reports.student_encounter_diagnoses @user.id
   
   # get data for the procedures table
   @procedures = Reports.student_encounter_procedures @user.id
   # ActiveRecord::Base.logger.debug "@procedures.count: #{@procedures.count}"
   # ActiveRecord::Base.logger.debug "@procedures: #{@procedures}"


   respond_to do |format|
     format.html # index.html.erb
     format.xml  { render :xml => @encounters }
   end

  end
  
  def summary
  end
end
