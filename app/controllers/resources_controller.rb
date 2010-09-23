require 'pp'
require "digest/sha1"
require "stringio"
require 'FileUtils'

class ResourcesController < ApplicationController
  # GET /resources
  # GET /resources.xml
  def index
    @resources = Resource.all
    @clerkship = Clerkship.find_by_name('Pediatrics')    
    @dxcs = DiagnosisCategory.find_all_by_clerkship_id(@clerkship.id)
    @dxs = Diagnosis.find_all_by_clerkship_id(@clerkship.id)
    @procedures = Procedure.find_all_by_clerkship_id([@clerkship.id, -1])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resources }
    end
  end

  # GET /resources/1
  # GET /resources/1.xml
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.xml
  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  # POST /resources
  # POST /resources.xml
  def create
    # Resource: sha1, filelocation, url, score
    # ResourceInstance: resource_id, tag, tag_id, title, description, filename_orig, privacy (P|F|A)
=begin
    truncate table resource_instances;
    truncate table resources;
=end
    
    r = Resource.new(params[:resource])
    ri = ResourceInstance.new(params[:resource_instance])
    ri.tag,ri.tag_id = ri.tag.split('_')
    ri.creator = @user
    ri.updater = @user
    
	if (r.filelocation == 'local')
		tempfile = ri.filename_orig
		ri.filename_orig = tempfile.original_path
		# compute requested resource sha1 (to see if it exists in the database already)
		rsha1 = sha1(tempfile) 
		ext = tempfile
		r.url = UPLOAD_DIR + rsha1 + '.' + ri.filename_orig.split('.').last
	else 
		rsha1 = sha1(StringIO.new(r.url))
	end
	
    # lookup resource by sha1
    r2 = Resource.find_by_sha1 rsha1
    if r2.nil? 
      # Resource not in database
      
      # move uploaded file to 'uploads' folder
      FileUtils.mv tempfile.path, File.join(UPLOAD_DIR, rsha1+'.'+ri.filename_orig.split('.').last) if r.filelocation == 'local'
      
      # save resource_instance and its parent resource in database
      ri.resource = r
      r.sha1 = rsha1
      r.creator = @user
      r.updater = @user
      ri.save!
    else
      # resource already in db, just create resource_instance 
      ri.resource = r2
      ri.save!
    end
    
    render :text => "ok"

    # @resource = Resource.new(params[:resource])
    # @ri = ResourceInstance.new
    
    # @resource = Resource.new(params[:resource])
    # 
    # respond_to do |format|
    #   if @resource.save
    #     flash[:notice] = 'Resource was successfully created.'
    #     format.html { redirect_to(@resource) }
    #     format.xml  { render :xml => @resource, :status => :created, :location => @resource }
    #   else
    #     format.html { render :action => "new" }
    #     format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
    #   end
    # end
  end

  # PUT /resources/1
  # PUT /resources/1.xml
  def update
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        flash[:notice] = 'Resource was successfully updated.'
        format.html { redirect_to(@resource) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.xml
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to(resources_url) }
      format.xml  { head :ok }
    end
  end
  
  def up_vote
	@resource = Resource.find(params[:id])
	@resource.score += 1
	@resource.save()
	respond_to do  |format|
      format.html { redirect_to resources_path }
      format.js {render :layout => false}
    end
  end
  
  def down_vote
	@resource = Resource.find(params[:id])
	@resource.score += -1
	@resource.save()
	respond_to do  |format|
      format.html { redirect_to resources_path }
      format.js {render :layout => false}
    end
  end
  
  def by_dx
    # render :text => params[:id]
    dx_ids = params[:id].split ","
    @ris = Resource.find_by_dx(dx_ids)
    render :json => @ris
  end

private
  def sha1 (io)
    digest = Digest::SHA1.new
    digest.update io.read(8192) until io.eof
    digest.hexdigest
  end
end
