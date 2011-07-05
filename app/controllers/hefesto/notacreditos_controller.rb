module Hefesto
  class NotacreditocpsController < AuthorizedController
    # GET /notacreditos
    # GET /notacreditos.xml
    before_filter :authenticate_user!
  
    def index
      @notacreditos = Notacredito.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @notacreditos }
      end
    end

    # GET /notacreditos/1
    # GET /notacreditos/1.xml
    def show
      @notacredito = Notacredito.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @notacredito }
      end
    end

    # GET /notacreditos/new
    # GET /notacreditos/new.xml
    def new
      @notacredito = Notacredito.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @notacredito }
      end
    end

    # GET /notacreditos/1/edit
    def edit
      @notacredito = Notacredito.find(params[:id])
    end

    # POST /notacreditos
    # POST /notacreditos.xml
    def create
      @notacredito = Notacredito.new(params[:notacredito])

      respond_to do |format|
        if @notacredito.save
          format.html { redirect_to(@notacredito, :notice => 'Notacredito was successfully created.') }
          format.xml  { render :xml => @notacredito, :status => :created, :location => @notacredito }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @notacredito.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /notacreditos/1
    # PUT /notacreditos/1.xml
    def update
      @notacredito = Notacredito.find(params[:id])

      respond_to do |format|
        if @notacredito.update_attributes(params[:notacredito])
          format.html { redirect_to(@notacredito, :notice => 'Notacredito was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @notacredito.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /notacreditos/1
    # DELETE /notacreditos/1.xml
    def destroy
      @notacredito = Notacredito.find(params[:id])
      @notacredito.destroy

      respond_to do |format|
        format.html { redirect_to(notacreditos_url) }
        format.xml  { head :ok }
      end
    end
  end
end