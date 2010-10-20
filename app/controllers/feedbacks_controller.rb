class FeedbacksController < ApplicationController
    # GET /feedbacks
    # GET /feedbacks.xml
    def index
      if @user.primary_role == "Student"
        render :file => "public/401.html", :status => :unauthorized 
        return
      end

      @feedbacks = Feedback.find :all
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @feedbacks }
      end
    end

    # GET /feedbacks/1
    # GET /feedbacks/1.xml
    def show
      @feedback = Feedback.find params[:id]
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @feedback }
      end
    end

    # GET /feedbacks/new
    # GET /feedbacks/new.xml
    def new
      @feedback = Feedback.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @feedback }
      end
    end

    # GET /feedbacks/1/edit
    def edit
      if @user.primary_role == "Student"
        render :file => "public/401.html", :status => :unauthorized 
        return
      end

      @feedback = Feedback.find(params[:id])
    end

    # POST /feedbacks
    # POST /feedbacks.xml
    def create
      ActiveRecord::Base.logger.debug "•••• In feedbackController - create"
      @feedback = Feedback.new(params[:feedback])
      @feedback.creator = @user
      @feedback.updater = @user
      
      # now subject is not visible - take 100 characters from body and make that the subject
      body = []
      body = @feedback.body
      bodycount = body.length
      slicesize = (bodycount > 100) ? 100 : bodycount
      @feedback.subject = body.slice(1, slicesize) || " "
      
      respond_to do |format|
        if @feedback.save
          flash[:notice] = 'Feedback was successfully created.'
          format.html { redirect_to(@feedback) }
          format.xml  { render :xml => @feedback, :status => :created, :location => @feedback }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @feedback.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /feedbacks/1
    # PUT /feedbacks/1.xml
    def update
      if @user.primary_role == "Student"
        render :file => "public/401.html", :status => :unauthorized 
        return
      end

      @feedback = Feedback.find(params[:id])

      respond_to do |format|
        if @resource.update_attributes(params[:feedback])
          flash[:notice] = 'Feedback was successfully updated.'
          format.html { redirect_to(@feedback) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @feedback.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /feedbacks/1
    # DELETE /feedbacks/1.xml
    def destroy
      if @user.primary_role == "Student"
        render :file => "public/401.html", :status => :unauthorized 
        return
      end

      @feedback = Feedback.find(params[:id])
      @feedback.destroy

      respond_to do |format|
        format.html { redirect_to(feedbacks_url) }
        format.xml  { head :ok }
      end
    end
end