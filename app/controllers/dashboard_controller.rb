class DashboardController < ApplicationController
  
  def index
   clerkship_id = Clerkship.find_by_name 'Pediatrics'
   @statuses = Compliance.status_by_user(@user.id, clerkship_id, 'ER')
   
   @hx_total, @px_total, @hx_required_total, @px_required_total = 0, 0, 0, 0
   
   @statuses.each do |s|
     @hx_total += s.hx_done
     @px_total += s.px_done
     @hx_required_total += s.hx_required
     @px_required_total += s.px_required
   end
   
   respond_to do |format|
     format.html # index.html.erb
     format.xml  { render :xml => @encounters }
   end

  end
  
  def summary
  end
end
