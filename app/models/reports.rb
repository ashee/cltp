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
   # Student Encounter Diagnoses (problems) totals 
   # Count of Diagnoses/problems a student has seen
   # This is displayed in the dashboard.
   # This routine is called from the dashboard_controller
   #--------------------------------------------
   def self.student_encounter_diagnoses(student_id)
     sql = <<-EOF
        select  edx.dx_id, count(*) as count, d.name as name
        from encounter_dx edx
        join dx d on edx.dx_id = d.id
        where edx.created_by = #{student_id}
        group by d.id
        order by count desc, name asc
        EOF
     ActiveRecord::Base.connection.select_all sql
   end

  #--------------------------------------------
    # Student Encounter Procedures totals 
    # Count of Encounter Procedures a student has logged
    # This is displayed in the dashboard.
    # This routine is called from the dashboard_controller
    #--------------------------------------------
    def self.student_encounter_procedures(student_id)
      sql = <<-EOF
         select  ep.encounter_id, count(*) as count, p.name as name
         from encounter_procedures ep
         join procedures p on ep.procedure_id = p.id
         where ep.created_by = #{student_id}
         group by p.id
         order by count desc, name asc
         EOF
      ActiveRecord::Base.connection.select_all sql
    end

        
  #--------------------------------------------
  # Encounters by Care Setting 
  # Numbers of Patients each student has seen on Inpatient, Outpatient and Newborn Nursery
  #--------------------------------------------
  def self.encounters_by_care_settings
    sql = <<-EOF
      select u.email as 'Email', u.firstname as 'FirstName', u.lastname as 'LastName',
        sum(if(c.care_setting='OP',1,0)) as 'Outpatient',
        sum(if(c.care_setting='IP',1,0)) as 'Inpatient',
        sum(if(c.care_setting='NB',1,0)) as 'Newborn'
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
        sum(if(c.care_setting='OP',1,0)) as 'Outpatient',
        sum(if(c.care_setting='IP',1,0)) as 'Inpatient',
        sum(if(c.care_setting='NB',1,0)) as 'Newborn',
             c.clinic_name, 
             c.care_setting, 
             c.location
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
          u.firstname as 'FirstName', 
          u.lastname as 'LastName',
          u.email as 'Email',
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
   # Individual diagnoses performed by site
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
  # Histories and Physicals Observed and Performed by student
  #-------------------------------------------    
   def self.hnp_observed_vs_performed
    sql = <<-EOF
    select 
       u.firstname as 'FirstName',
       u.lastname as 'LastName',
       u.email as 'Email',
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
  # Histories and Physicals Observed and Performed by site
   #-------------------------------------------    
    def self.site_hnp_observed_vs_performed
     sql = <<-EOF
     select 
          c.care_setting as "CareSetting", c.clinic_name as "ClinicName", c.location as "Location",
         sum(if(e.hx='P' or e.hx='B',1,0)) as 'hxPerformed',
         sum(if(e.hx='O' or e.hx='B',1,0)) as 'hxObserved',
         sum(if(e.px='P' or e.px='B',1,0)) as 'pxPerformed',
         sum(if(e.px='O' or e.px='B',1,0)) as 'pxObserved'
         from encounters e 
         join clinics c on c.id = e.clinic_id
        where e.clerkship_id = 1
        group by c.location;
      EOF

     ret = ActiveRecord::Base.connection.select_all sql  
     return ret
   end
  
  #-------------------------------------------
  # Individual diagnoses that selected student has performed
  #-------------------------------------------    
  def self.student_individual_dx(student_id)       
    sql = <<-EOF
      select edx.dx_id,  count(edx.dx_id) as 'cnt', diagnoses.name as 'dxname'
      from encounter_dx edx
      join dx diagnoses on edx.dx_id = diagnoses.id
      where edx.created_by = #{student_id}
      group by edx.dx_id
      order by diagnoses.id
    EOF

    sqlResult = ActiveRecord::Base.connection.select_all sql     
    sqlResult
        
 end
 
  #-------------------------------------------
  # Individual diagnoses performed at selected site
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

   #-------------------------------------------
   # Diagnoses reported as as Other
   #-------------------------------------------    
   def self.other_dx
     sql = <<-EOF
        select u.firstname, u.lastname, c.care_setting, c.clinic_name, c.location, edx.other
        from encounter_dx edx
          join users u on edx.created_by = u.id
          join encounters es on es.id = edx.encounter_id
          join clinics c on c.id = es.clinic_id 
        where edx.dx_id=166
      EOF
     sqlResult = ActiveRecord::Base.connection.select_all sql     
     sqlResult

   end

   #-------------------------------------------
    # Health Maintenance Diagnoses reported by age range sub category
    #-------------------------------------------    
    def self.health_m_dx_by_age
      sql = <<-EOF
      SELECT c.care_setting, c.clinic_name, c.location, 
        sum(if(edx.dx_id=92,1,0)) as 'infant1-12',
        sum(if(edx.dx_id=93,1,0)) as 'Well Care Infant 1-12 months',
        sum(if(edx.dx_id=94,1,0)) as 'Well Care Child 1-5 years',
        sum(if(edx.dx_id=95,1,0)) as 'Well Care Child 6-12 years',
        sum(if(edx.dx_id=96,1,0)) as 'Well Care Child 13-18 years',
        sum(if(edx.dx_id=97,1,0)) as 'Well Care Young Adult 19-23 years'
     from encounter_dx edx 
        join users u on edx.created_by = u.id
        join encounters es on es.id = edx.encounter_id
        join clinics c on c.id = es.clinic_id
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

