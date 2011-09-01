module Hefesto 
  class FacturasController < AuthorizedController
    before_filter :find_supplier
    before_filter :find_factura, :except => [:index, :new, :create]
    # GET /facturas
    # GET /facturas.xml
  
    def index
      #@search = @supplier.search(params[:search])
      #@facturas = @search.page(params[ :page ]).per(10)
      
      @facturas = @supplier.facturas
      
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @facturas }
      end
    end

    # GET /facturas/1
    # GET /facturas/1.xml
    def show
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @factura }
        format.pdf do

          #unless @factura.isprinted?
             @entry = @factura.to_entry
             unless @entry.save
               flash[:error] = @entry.errors.full_messages.join("\n")
               redirect_to [@factura.supplier,:facturas]
               return
             end
          #end

          dump_tmp_filename = Rails.root.join('tmp',@factura.cache_key)
          Dir.mkdir(dump_tmp_filename.dirname) unless File.directory?(dump_tmp_filename.dirname)
          @factura.save_pdf_to(dump_tmp_filename)
          send_file(dump_tmp_filename, :type => :pdf, :disposition => 'attachment', :filename => "#{@supplier.razonsocial}-factura-#{@factura.numero}.pdf")
          File.delete(dump_tmp_filename)
        end
      end
    end

    # GET /facturas/new
    # GET /facturas/new.xml
    def new
      @factura = @supplier.facturas.build

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @factura }
      end
    end

    # GET /facturas/1/edit
    def edit
    end

    # POST /facturas
    # POST /facturas.xml
    def create
      @factura = @supplier.facturas.build(params[:hefesto_factura])
      
      respond_to do |format|
        if @factura.save
          format.html { redirect_to([@supplier, @factura], :notice => 'Factura was successfully created.') }
          format.xml  { render :xml => @factura, :status => :created, :location => [@supplier, @factura] }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @factura.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /facturas/1
    # PUT /facturas/1.xml
    def update
      respond_to do |format|
        if @factura.update_attributes(params[:factura])
          format.html { redirect_to([@supplier, @factura], :notice => 'Factura was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @factura.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /facturas/1
    # DELETE /facturas/1.xml
    def destroy
      @factura.destroy unless @factura.isprinted?

      respond_to do |format|
        format.html { redirect_to(supplier_facturas_url(@supplier)) }
        format.xml  { head :ok }
      end
    end
  
  protected
  
  def find_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end

  def find_factura
    @factura = @supplier.facturas.find(params[:id])
  end
end

end