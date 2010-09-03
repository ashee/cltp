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

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @encounter }
    end
  end

  # GET /encounters/new
  # GET /encounters/new.xml
  def new
	  clerkship = Clerkship.find_all_by_name('Pediatrics')
    @encounter = Encounter.new
	  @cs = CareSetting.all
	  @clinics = Clinic.all
	  dxc = DiagnosisCategory.find_all_by_clerkship_id(clerkship.id)

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

  # GET /encounters/1/edit
  def edit
    @encounter = Encounter.find(params[:id])
  end

  # POST /encounters
  # POST /encounters.xml
  def create
	#p params[:encounter]
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
	p params[:hx]
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

    respond_to do |format|
      if @encounter.update_attributes(params[:encounter])
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
