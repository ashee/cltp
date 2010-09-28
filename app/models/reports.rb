=begin
  1. Numbers of Patients each student has seen on Inpatient, Outpatient and Newborn Nursery, displaying the class average etc as it does now is kind of nice too..especially for the students to be able to see how they compare.
      *LWK* Should students be able to see this
      *LWK* does Jenny want a faculty view which lists all students?
      
      
  2.Individual diagnoses that each student has performed
  
  3. H&P observed vs. performed on their own
  
  4. View each student and see how many diagnoses they are seeing in each of our major categories
      I would like to be able to view each student and see how many diagnoses they are seeing 
      in each of our major categories (from that COMSEP table). 
      So that each individual diagnosis they enter gets mapped to a larger category and I can see like an Excel type table:
       with each student on y axis, 
       major categories of dx on X axis 
       and I could see totals...
       so I'd be like...WOW..everyone is seeing Chronic Disease but oh my gosh...no one is seeing any Dermatology etc.....
  
  5. Summary table of how many dx are observed vs. actually seen by students
  
  6. Each of the above by site
  
=end
class Reports
  
  def self.encounters_by_care_settings
    sql = <<-EOF
      select u.username as 'Username',
      sum(if(c.care_setting='OP' or c.care_setting='ER',1,0)) as 'Outpatient',
            sum(if(c.care_setting='IP',1,0)) as 'Inpatient',
             sum(if(c.care_setting='NB',1,0)) as 'Newborn',
             u.firstname as 'Firstname', 
             u.lastname as 'Lastname'
      from encounters e join clinics c on e.clinic_id = c.id
      join users u on e.created_by = u.id
      where e.clerkship_id = 1
      group by e.created_by;
    EOF
    
    ActiveRecord::Base.connection.select_all sql
  end
  
 
  #-------------------------------------------
  # self.dx_categories
  #-------------------------------------------
  # select u.username as 'Username',
  # sum(if(edx.dx_id=1,1,0)) as 'Behavior',
  # sum(if(edx.dx_id=2,1,0)) as 'Cardiology',
  # sum(if(edx.dx_id=3,1,0)) as 'Chronic Medical Problem',
  # sum(if(edx.dx_id=4,1,0)) as 'Dermatology',
  # sum(if(edx.dx_id=5,1,0)) as 'Emergent Clinical Problem',
  # sum(if(edx.dx_id=6,1,0)) as 'Gastroenterology',
  # sum(if(edx.dx_id=7,1,0)) as 'Growth',
  # sum(if(edx.dx_id=8,1,0)) as 'H/O',
  # sum(if(edx.dx_id=9,1,0)) as 'Health Maintenance',
  # sum(if(edx.dx_id=10,1,0)) as 'Infectious Disease',
  # sum(if(edx.dx_id=11,1,0)) as 'Neurology',
  # sum(if(edx.dx_id=12,1,0)) as 'Nutrition',
  # sum(if(edx.dx_id=13,1,0)) as 'Respiratory',
  # sum(if(edx.dx_id=14,1,0)) as 'Unique Condition',
  # sum(if(edx.dx_id=15,1,0)) as 'Other',
  #       u.firstname as 'Firstname', 
  #       u.lastname as 'Lastname'
  #   from encounters e 
  #   join users u on e.created_by = u.id
  #   join encounter_dx edx on e.created_by = u.id
  #    where e.clerkship_id = 1
  #   group by e.created_by;
    
  def self.dx_by_students
    dxcats = DiagnosisCategory.all
    ActiveRecord::Base.logger.debug "dxcats: #{dxcats}"
    
     template = %Q{sum(if(edx.dx_id=%s,1,0)) as '%s'}
       
     partialSqlStatement = dxcats.map { |dxc| 
       sprintf template, dxc["id"], dxc["name"]
     }.join(",\n")
    
    
      sql = <<-EOF
        select 
            u.firstname as 'Firstname', 
            u.lastname as 'Lastname',
            #{partialSqlStatement}
          from encounters e 
          join users u on e.created_by = u.id
          join encounter_dx edx on e.created_by = u.id
          where e.clerkship_id = 1
          group by e.created_by;
  
  
  
      EOF

      # Calling ActiveRecord::Base.connection.execute(sql) in order to get the fields of each record returned
      # in the correct order.  Using the select_all method returns a hash of the rows but they are not ordered 
      # correctly
      
      sqlResult = ActiveRecord::Base.connection.execute sql     
 
      # this returns a Mysql::Result object.
      # first check whether something was returned
      if sqlResult != nil
        # first extract the field names
        fieldObjectArray = sqlResult.fields
        
        fieldNames = Array.new
        fieldObjectArray.each do |aField|
            fieldNames << aField.name
          end               
      
        # now extract the rows of data
       rows = Array.new
       sqlResult.each do |row|
          rows << row
        end               
        sqlResult.free;
      end
      
      fieldNamesAndDataArray = Array.new
      fieldNamesAndDataArray << fieldNames << rows
      # FOR DEBUGGING ActiveRecord::Base.logger.debug "fieldNamesAndDataArray: #{fieldNamesAndDataArray}"
      return fieldNamesAndDataArray
    end
  
  
  def self.hnp_observed_vs_performed
    
  end
  
  def self.dx_observed_vs_performed
    sql = <<-EOF
    select 
       u.firstname as 'FirstName',
       u.lastname as 'LastName',
        sum(if(e.hx='P' or e.hx='B',1,0)) as 'hxPerformed',
        sum(if(e.hx='O' or e.hx='B',1,0)) as 'hxObserved',
        sum(if(e.px='P' or e.px='B',1,0)) as 'pxPerformed',
        sum(if(e.px='O' or e.px='B',1,0)) as 'pxObserved'
        from encounters e 
       join users u on e.created_by = u.id
       where e.clerkship_id = 1
       group by e.created_by;
     EOF
    
    ActiveRecord::Base.logger.debug "sql: #{sql}"
    ret = ActiveRecord::Base.connection.select_all sql  
    ActiveRecord::Base.logger.debug "ret: #{ret}"
    return ret
  end
  
  def self.summary_dx_observed_vs_performed
  end
  
    def self.student_individual_dx
      # Need to populate the popup menu with all the users.
   
      sql = <<-EOF
      select distinct edx.dx_id,
             dx.name as 'dxname'
           from encounter_dx edx
           join dx on edx.dx_id = dx.id
           EOF
      
      user_id = 1
      sql = <<-EOF
      select distinct edx.dx_id,
             dx.name as 'dxname'
           from encounter_dx edx
           join dx on edx.dx_id = dx.id
           EOF
      sql = sql + "where edx.created_by = "
      sql = sql + user_id.to_s
      sql = sql + " order by dx_id;"

      ActiveRecord::Base.logger.debug "sql: #{sql}"

      sqlResult = ActiveRecord::Base.connection.select_all sql 
      
      ActiveRecord::Base.logger.debug "sqlResult: #{sqlResult}"
      
          
   end
   
  end