class CampersController < ApplicationController
  # GET /campers
  # GET /campers.xml
  def index
    @campers = Camper.find(:all, :conditions => params[:troop_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @campers }
    end
  end

  # GET /campers/1
  # GET /campers/1.xml
  def show
    @camper = Camper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @camper }
    end
  end

  # GET /campers/new
  # GET /campers/new.xml
  def new
    @camper = Camper.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @camper }
    end
  end

  # GET /campers/1/edit
  def edit
    @camper = Camper.find(params[:id])
  end

  # POST /campers
  # POST /campers.xml
  def create
    @camper = Camper.new(params[:camper])

    respond_to do |format|
      if @camper.save
        flash[:notice] = 'Camper was successfully created.'
        format.html { redirect_to(@camper) }
        format.xml  { render :xml => @camper, :status => :created, :location => @camper }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @camper.errors, :status => :unprocessable_entity }
      end
    end

    @camper.troop_id = params[:troop_id]
  end

  # PUT /campers/1
  # PUT /campers/1.xml
  def update
    @camper = Camper.find(params[:id])

    respond_to do |format|
      if @camper.update_attributes(params[:camper])
        flash[:notice] = 'Camper was successfully updated.'
        format.html { redirect_to(@camper) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @camper.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /campers/1
  # DELETE /campers/1.xml
  def destroy
    @camper = Camper.find(params[:id])
    @camper.destroy

    respond_to do |format|
      format.html { redirect_to(campers_url) }
      format.xml  { head :ok }
    end
  end
end
