class ReportsController < ApplicationController
  before_filter :access_control
  
  def index
  end
  
  def encounters_by_care_settings
  	@reportlinearray = Reports.encounters_by_care_settings
    ActiveRecord::Base.logger.debug "@reportlinearray: #{@reportlinearray}"
  end

  def dx_by_students
 	  @reportarray = Reports.dx_by_students
  end

  def hnp_observed_vs_performed
    @reportlinearray = Reports.hnp_observed_vs_performed
  end

  def dx_observed_vs_performed
  end

  def summary_dx_observed_vs_performed
  end
   
  def student_individual_dx
    @students = User.students
  end

  def render_student_individual_dx
    student_id = params[:student_id]
    @student = User.find_by_id student_id
    @items = Reports.student_individual_dx student_id
    render :layout => false
  end
  
  def access_control
    if @user.primary_role == "Student"
      render :file => "public/401.html", :status => :unauthorized 
      return
    end
    
  end

end