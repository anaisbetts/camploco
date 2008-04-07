class TroopsController < ApplicationController
  # GET /troops
  # GET /troops.xml
  def index
    @troops = Troop.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @troops }
    end
  end

  # GET /troops/1
  # GET /troops/1.xml
  def show
    @troop = Troop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @troop }
    end
  end

  # GET /troops/new
  # GET /troops/new.xml
  def new
    @troop = Troop.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @troop }
    end
  end

  # GET /troops/1/edit
  def edit
    @troop = Troop.find(params[:id])
  end

  # POST /troops
  # POST /troops.xml
  def create
    @troop = Troop.new(params[:troop])

    respond_to do |format|
      if @troop.save
        flash[:notice] = 'Troop was successfully created.'
        format.html { redirect_to(@troop) }
        format.xml  { render :xml => @troop, :status => :created, :location => @troop }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @troop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /troops/1
  # PUT /troops/1.xml
  def update
    @troop = Troop.find(params[:id])

    respond_to do |format|
      if @troop.update_attributes(params[:troop])
        flash[:notice] = 'Troop was successfully updated.'
        format.html { redirect_to(@troop) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @troop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /troops/1
  # DELETE /troops/1.xml
  def destroy
    @troop = Troop.find(params[:id])
    @troop.destroy

    respond_to do |format|
      format.html { redirect_to(troops_url) }
      format.xml  { head :ok }
    end
  end
end
