class GhPushesController < ApplicationController
  # GET /gh_pushes
  # GET /gh_pushes.xml
  def index
    @gh_pushes = GhPush.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gh_pushes }
    end
  end

  # GET /gh_pushes/1
  # GET /gh_pushes/1.xml
  def show
    @gh_push = GhPush.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gh_push }
    end
  end

  # GET /gh_pushes/new
  # GET /gh_pushes/new.xml
  def new
    @gh_push = GhPush.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gh_push }
    end
  end

  # GET /gh_pushes/1/edit
  def edit
    @gh_push = GhPush.find(params[:id])
  end

  # POST /gh_pushes
  # POST /gh_pushes.xml
  def create
    @gh_push = GhPush.new(params[:gh_push])

    respond_to do |format|
      if @gh_push.save
        format.html { redirect_to(@gh_push, :notice => 'Gh push was successfully created.') }
        format.xml  { render :xml => @gh_push, :status => :created, :location => @gh_push }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gh_push.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gh_pushes/1
  # PUT /gh_pushes/1.xml
  def update
    @gh_push = GhPush.find(params[:id])

    respond_to do |format|
      if @gh_push.update_attributes(params[:gh_push])
        format.html { redirect_to(@gh_push, :notice => 'Gh push was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gh_push.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gh_pushes/1
  # DELETE /gh_pushes/1.xml
  def destroy
    @gh_push = GhPush.find(params[:id])
    @gh_push.destroy

    respond_to do |format|
      format.html { redirect_to(gh_pushes_url) }
      format.xml  { head :ok }
    end
  end
  
  def commit
  end
end
