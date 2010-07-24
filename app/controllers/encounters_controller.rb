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

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @encounter }
    end
  end

  # GET /encounters/new
  # GET /encounters/new.xml
  def new
    @encounter = Encounter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @encounter }
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
    @encounter = Encounter.new(params[:encounter])
    @encounter.period = Period.new(:name  => params[:encounter]['period'])

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
