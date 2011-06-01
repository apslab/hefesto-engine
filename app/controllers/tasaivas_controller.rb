class TasaivasController < ApplicationController
  # GET /tasaivas
  # GET /tasaivas.xml
  def index
    @tasaivas = Tasaiva.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasaivas }
    end
  end

  # GET /tasaivas/1
  # GET /tasaivas/1.xml
  def show
    @tasaiva = Tasaiva.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tasaiva }
    end
  end

  # GET /tasaivas/new
  # GET /tasaivas/new.xml
  def new
    @tasaiva = Tasaiva.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tasaiva }
    end
  end

  # GET /tasaivas/1/edit
  def edit
    @tasaiva = Tasaiva.find(params[:id])
  end

  # POST /tasaivas
  # POST /tasaivas.xml
  def create
    @tasaiva = Tasaiva.new(params[:tasaiva])

    respond_to do |format|
      if @tasaiva.save
        format.html { redirect_to(@tasaiva, :notice => 'Tasaiva was successfully created.') }
        format.xml  { render :xml => @tasaiva, :status => :created, :location => @tasaiva }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tasaiva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasaivas/1
  # PUT /tasaivas/1.xml
  def update
    @tasaiva = Tasaiva.find(params[:id])

    respond_to do |format|
      if @tasaiva.update_attributes(params[:tasaiva])
        format.html { redirect_to(@tasaiva, :notice => 'Tasaiva was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tasaiva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasaivas/1
  # DELETE /tasaivas/1.xml
  def destroy
    @tasaiva = Tasaiva.find(params[:id])
    @tasaiva.destroy

    respond_to do |format|
      format.html { redirect_to(tasaivas_url) }
      format.xml  { head :ok }
    end
  end
end
