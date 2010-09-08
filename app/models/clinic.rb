class Clinic < ActiveRecord::Base

	def displayname
	  if (category == 'Primary Care') then return "#{location}" end
	  if (category == 'Specialty') then return "#{clinic_name}" end
	  if (category == 'Inpatient') then return "#{code}" end
	  if (category == 'Emergency') then return "#{clinic_name}" end
	  if (category == 'Newborn') then return "#{clinic_name}" end
	end
  
end