class CondicionivasController < ApplicationController
  # GET /condicionivas
  # GET /condicionivas.xml
  def index
    @condicionivas = Condicioniva.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @condicionivas }
    end
  end

  # GET /condicionivas/1
  # GET /condicionivas/1.xml
  def show
    @condicioniva = Condicioniva.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @condicioniva }
    end
  end

  # GET /condicionivas/new
  # GET /condicionivas/new.xml
  def new
    @condicioniva = Condicioniva.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @condicioniva }
    end
  end

  # GET /condicionivas/1/edit
  def edit
    @condicioniva = Condicioniva.find(params[:id])
  end

  # POST /condicionivas
  # POST /condicionivas.xml
  def create
    @condicioniva = Condicioniva.new(params[:condicioniva])

    respond_to do |format|
      if @condicioniva.save
        format.html { redirect_to(@condicioniva, :notice => 'Condicioniva was successfully created.') }
        format.xml  { render :xml => @condicioniva, :status => :created, :location => @condicioniva }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @condicioniva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /condicionivas/1
  # PUT /condicionivas/1.xml
  def update
    @condicioniva = Condicioniva.find(params[:id])

    respond_to do |format|
      if @condicioniva.update_attributes(params[:condicioniva])
        format.html { redirect_to(@condicioniva, :notice => 'Condicioniva was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @condicioniva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /condicionivas/1
  # DELETE /condicionivas/1.xml
  def destroy
    @condicioniva = Condicioniva.find(params[:id])
    @condicioniva.destroy

    respond_to do |format|
      format.html { redirect_to(condicionivas_url) }
      format.xml  { head :ok }
    end
  end
end
