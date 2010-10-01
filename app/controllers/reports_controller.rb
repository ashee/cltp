class ReportsController < ApplicationController
  def index
  end
  
  def encounters_by_care_settings
  	@reportlinearray = Reports.encounters_by_care_settings
    ActiveRecord::Base.logger.debug "@reportlinearray: #{@reportlinearray}"
  end
  
    def site_encounters_by_care_settings
  	@reportlinearray = Reports.site_encounters_by_care_settings
  end

  def dx_by_students
 	  @reportarray = Reports.dx_by_students
  end
  
    def dx_by_sites
 	  @reportarray = Reports.dx_by_sites
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
  
  def site_individual_dx
    @sites = Clinic.all
  end

  def render_site_individual_dx
    site_id = params[:site_id]
    @site = Clinic.find_by_id site_id
    @items = Reports.site_individual_dx site_id
    render :layout => false
  end

end