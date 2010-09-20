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
end
