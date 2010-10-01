=begin
  1. Numbers of Patients each student has seen on Inpatient, Outpatient and Newborn Nursery, 
      displaying the class average etc as it does now is kind of nice too..
      especially for the students to be able to see how they compare.      
      
  2. Individual diagnoses that each student has performed
  
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
  
  #--------------------------------------------
  # Encounters by Care Setting 
  # Numbers of Patients each student has seen on Inpatient, Outpatient and Newborn Nursery
  #--------------------------------------------
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
  
  #--------------------------------------------
  # Encounters by Care Setting 
  # by site
  #--------------------------------------------
  def self.site_encounters_by_care_settings
    sql = <<-EOF
      select 
      sum(if(c.care_setting='OP' or c.care_setting='ER',1,0)) as 'Outpatient',
            sum(if(c.care_setting='IP',1,0)) as 'Inpatient',
             sum(if(c.care_setting='NB',1,0)) as 'Newborn',
             c.clinic_name, c.care_setting , c.location
      from encounters e join clinics c on e.clinic_id = c.id
      where e.clerkship_id = 1
      group by c.location;
    EOF
    
    ActiveRecord::Base.connection.select_all sql
  end
  
  #-------------------------------------------
   # Individual diagnoses that each student has performed
   #-------------------------------------------    
    def self.dx_by_students
    dxcats = DiagnosisCategory.all

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
        join encounter_dx edx on edx.encounter_id = e.id
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
      fieldObjectArray = sqlResult.fetch_fields()

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
    return fieldNamesAndDataArray
  end
  
  #-------------------------------------------
   # Individual diagnoses that each student has performed
   #-------------------------------------------    
    def self.dx_by_sites
    dxcats = DiagnosisCategory.all

    template = %Q{sum(if(edx.dx_id=%s,1,0)) as '%s'}

    partialSqlStatement = dxcats.map { |dxc| 
    sprintf template, dxc["id"], dxc["name"]
    }.join(",\n")
    
    sql = <<-EOF
      select 
      c.care_setting as "CareSetting", c.clinic_name as "ClinicName", c.location as "Location",
          #{partialSqlStatement}
        from encounters e 
        join encounter_dx edx on e.id = edx.encounter_id
        join clinics c on c.id = e.clinic_id
        where e.clerkship_id = 1
        group by c.location;
    EOF
    
    sqlResult = ActiveRecord::Base.connection.execute sql     
    if sqlResult != nil
      # first extract the field names
      fieldObjectArray = sqlResult.fetch_fields()

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
    return fieldNamesAndDataArray
  end
  
  #-------------------------------------------
  # Individual diagnoses that each student has performed
  #-------------------------------------------    
   def self.hnp_observed_vs_performed
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

    ret = ActiveRecord::Base.connection.select_all sql  
    return ret
  end
  
  #-------------------------------------------
  # Individual diagnoses that each student has performed
  #-------------------------------------------    
  def self.student_individual_dx(student_id)
    # Need to populate the popup menu with all the users.
       
    sql = <<-EOF
      select distinct edx.dx_id, diagnoses.name as 'dxname'
      from encounter_dx edx
      join dx diagnoses on edx.dx_id = diagnoses.id
      where edx.created_by = #{student_id}
      order by diagnoses.id
    EOF

    ActiveRecord::Base.logger.debug "sql: #{sql}"

    sqlResult = ActiveRecord::Base.connection.select_all sql 
    
    ActiveRecord::Base.logger.debug "sqlResult: #{sqlResult}"
    
    sqlResult
        
 end
 
 #-------------------------------------------
  # Individual diagnoses at each site
  #-------------------------------------------    
  def self.site_individual_dx(site_id)
       
    sql = <<-EOF
      	select edx.dx_id, count(edx.dx_id) as 'cnt', diagnoses.name as 'dxname'
      	from encounter_dx edx
      	join dx diagnoses on edx.dx_id = diagnoses.id
      	join encounters e on e.id = edx.encounter_id
      	where e.clinic_id = #{site_id}
  		group by edx.dx_id
      	order by diagnoses.id
    EOF

    sqlResult = ActiveRecord::Base.connection.select_all sql     
    sqlResult
        
 end


   def self.summary_dx_observed_vs_performed
   end
 
    #-------------------------------------------
    # Diagnoses observed vs performed for each student
    #-------------------------------------------    
   def self.dx_observed_vs_performed
   end
     
end
