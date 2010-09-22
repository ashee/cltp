class EncountersController < ApplicationController
  # GET /encounters
  # GET /encounters.xml
  def index
    @encounters = Encounter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @encounters }
    end
  end

  # GET /encounters/1
  # GET /encounters/1.xml
  def show
    @encounter = Encounter.find(params[:id])
	  @encounterDiagnoses = @encounter.diagnoses
	  @encounterProcedures = @encounter.procedures
    @resources = Resource.find_by_encounter(@encounter.id)
    @rel_resources = Resource.find_related_by_encounter(@encounter.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @encounter }
    end
  end

  # GET /encounters/new
  # GET /encounters/new.xml
  def new	
  	@clerkship = Clerkship.find_by_name('Pediatrics')    
	@encounter = Encounter.new
	  @cs = CareSetting.all
	  @clinics = Clinic.all
	  @dxcs = DiagnosisCategory.find_all_by_clerkship_id(@clerkship.id)
    @dxs = Diagnosis.find_all_by_clerkship_id(@clerkship.id)
    @procedures = Procedure.find_all_by_clerkship_id([@clerkship.id, -1]) 
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @encounter }
    end
  end
  
  # GET /encounters/get_clerkships_by_care_setting/OP
  # GET /encounters/get_clerkships_by_care_setting/OP.xml
  def get_clerkships_by_care_setting
	  @clinics = Clinic.find_all_by_care_setting(params[:id])
    
    respond_to do  |format|
      format.html { redirect_to encounters_path }
      format.js {render :layout => false}
    end
  end
  
  # GET /encounters/writeup
  # GET /encounters/writeup.xml
  def writeup
    @encounter = Encounter.find(params[:id])

    respond_to do |format|
      format.html # writeup.html.erb
      format.xml  { render :xml => @encounter }
    end
  end
  
    # GET /encounters/writeup_feedback
  # GET /encounters/writeup_feedback.xml
  def writeup_feedback
    @encounter = Encounter.find(params[:id])

    respond_to do |format|
      format.html # writeup.html.erb
      format.xml  { render :xml => @encounter }
    end
  end
  
  # GET /encounters/writeup
  # GET /encounters/writeup.xml
  def resource_details
    @encounter = Encounter.find(params[:id])
	#render :layout => "layouts/popup"
    respond_to do |format|
      format.html # writeup.html.erb
      format.xml  { render :xml => @encounter }
    end
  end

  # GET /encounters/edit/1
  def edit
    @encounter = Encounter.find(params[:id])
    @attributes={params[:field]=>params[:value]}
    field = params[:field]
    $fieldval = params[:value]

    respond_to do |format|
      if @encounter.update_attributes(@attributes)
        flash[:notice] = 'Encounter was successfully updated.'
      	#format.html { redirect_to encounters_path }
      	format.js {render :layout => false}
      else
        flash[:notice] = 'Encounter was NOT successfully updated.'
      	#format.html { redirect_to encounters_path }
      	format.js {render :layout => false}
      end
    end    
  end

  # POST /encounters
  # POST /encounters.xml
  def create

	case
		when (params[:hx]['O'] == "1" && params[:hx]['P'] == "1")
			hx = 'B'
		when (params[:hx]['O'] == "1" && params[:hx]['P'] == "0") 
			hx = 'O'
		when (params[:hx]['O'] == "0" && params[:hx]['P'] == "1")
			hx = 'P'
		when (params[:hx]['O'] == "0" && params[:hx]['P'] == "0")
			hx = 'N'
		else
			hx = 'N'
	end
	case
		when (params[:px]['O'] == "1" && params[:px]['P'] == "1")
			px = 'B'
		when (params[:px]['O'] == "1" && params[:px]['P'] == "0") 
			px = 'O'
		when (params[:px]['O'] == "0" && params[:px]['P'] == "1")
			px = 'P'
		when (params[:px]['O'] == "0" && params[:px]['P'] == "0")
			px = 'N'
		else 
			px = 'N'
	end
    @encounter = Encounter.new("clerkship_id" => params[:encounter]['clerkship_id'], "clinic_id" => params[:encounter]['clinic_id'], "encounter_date" => params[:encounter]['encounter_date'], "patient_id" => 1, "age" => params[:encounter]['age'], "gender" => params[:encounter]['gender'], "hx" => hx, "px" => px, "notes" => params[:encounter]['notes'], "created_by" => 1, "updated_by" => 1)
    
    respond_to do |format|
      if @encounter.save
        #save single primary problem
        dx_xref = Diagnosis.find_by_name params[:encounter]['primary_problem'].split(' > ').last
        @edx = @encounter.diagnoses.new("encounter_id" => @encounter.id, "dx_type" => 'P', "dx_id" => dx_xref.id, "created_by" => 1, "updated_by" => 1)
        @edx.save
        #loop and save secondary problems
        for sdx in params[:encounter]['secondary_problems'].split(', ')
          dx_xref = Diagnosis.find_by_name sdx.split(' > ').last
          @edx = @encounter.diagnoses.new("encounter_id" => @encounter.id, "dx_type" => 'S', "dx_id" => dx_xref.id, "created_by" => 1, "updated_by" => 1)
          @edx.save
        end #for dx loop
        #loop and save procedures observed
        for po in params[:encounter]['procedures_observed'].split(', ')
          proc_xref = Procedure.find_by_name(po)
          @po_new = @encounter.procedures.new("encounter_id" => @encounter.id, "participation_type" => 'O', "procedure_id" => proc_xref.id, "created_by" => 1, "updated_by" => 1)
          @po_new.save
        end #for procedures observed loop
        
        flash[:notice] = 'Encounter was successfully created.'
        format.html { redirect_to(@encounter) }
        format.xml  { render :xml => @encounter, :status => :created, :location => @encounter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @encounter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /encounters/1
  # PUT /encounters/1.xml
  def update
    @encounter = Encounter.find(params[:id])
    @attributes={params[:field]=>params[:value]}
    field = params[:field]
    fieldval = params[:value]

    respond_to do |format|
      if @encounter.update_attributes(@attributes)
        flash[:notice] = 'Encounter was successfully updated.'
        format.html { redirect_to(@encounter) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @encounter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /encounters/1
  # DELETE /encounters/1.xml
  def destroy
    @encounter = Encounter.find(params[:id])
    @encounter.destroy

    respond_to do |format|
      format.html { redirect_to(encounters_url) }
      format.xml  { head :ok }
    end
  end
end
