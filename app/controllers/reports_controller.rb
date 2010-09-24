class ReportsController < ApplicationController
  def index
  end
    
  def encounters_by_care_settings
    reportlinearray = Reports.encounters_by_care_settings
    @reportline = reportlinearray.shift
  end

  def dx_by_students
    @categories = Reports.dx_categories

    reportarray = Reports.dx_by_students
     @firstline = reportarray.shift
  end
  
  def hnp_observed_vs_performed
  end
  
  def dx_observed_vs_performed
  end
  
  def summary_dx_observed_vs_performed
  end

end