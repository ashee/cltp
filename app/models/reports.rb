=begin
  1. Numbers of Patients each student has seen on Inpatient, Outpatient and Newborn Nursery, displaying the class average etc as it does now is kind of nice too..especially for the students to be able to see how they compare.
  
  2.Individual diagnoses that each student
  
  3. H&P observed vs. performed on their own
  
  4. View each student and see how many diagnoses they are seeing in each of our major categories
  I would like to be able to view each student and see how many diagnoses they are seeing in each of our major categories (from that COMSEP table). So that each individual diagnosis they enter gets mapped to a larger category and I can see like an Excel type table with each student on y axis, major categories of dx on X axis and I could see totals...so I'd be like...WOW..everyone is seeing Chronic Disease but oh my gosh...no one is seeing any Dermatology etc.....
  
  5. Summary table of how many dx are observed vs. actually seen by students
  
  6. Each of the above by site
=end
class Reports
  
  def self.encounters_by_care_settings
    sql = <<-EOF
      select u.username,
             sum(if(c.care_setting='OP',1,0)) as 'Outpatient',
             sum(if(c.care_setting='IP',1,0)) as 'Inpatient',
             sum(if(c.care_setting='ER',1,0)) as 'Emergency',
             sum(if(c.care_setting='NB',1,0)) as 'Newborn'
      from encounters e join clinics c on e.clinic_id = c.id
      join users u on e.created_by = u.id
      where e.clerkship_id = 1
      group by e.created_by;
    EOF
    
    ActiveRecord::Base.connection.select_all sql
  end
  
  def self.dx_by_students
  end
  
  def self.hnp_observed_vs_performed
  end
  
  def self.dx_observed_vs_performed
  end
  
  def self.summary_dx_observed_vs_performed
  end
  
  def self.
  
end