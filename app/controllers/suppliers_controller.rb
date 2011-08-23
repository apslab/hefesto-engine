class SuppliersController < AuthorizedController
  # GET /suppliers
  # GET /suplierss.xml
  before_filter :filter_supplier, :only => [:show,:edit,:update,:destroy,:cuentacorriente]
  
  def index
    @search = Supplier.by_company(current_company).search(params[:search])
    @suppliers = @search.order("razonsocial").page(params[ :page ]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @suppliers }
      format.pdf do
         dump_tmp_filename = Rails.root.join('tmp',@suppliers.first.cache_key)
         Dir.mkdir(dump_tmp_filename.dirname) unless File.directory?(dump_tmp_filename.dirname)
         save_list_pdf_to(dump_tmp_filename,@suppliers) 
         send_file(dump_tmp_filename, :type => :pdf, :disposition => 'attachment', :filename => "proveedores.pdf")
         File.delete(dump_tmp_filename)           
      end
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @supplier }
      format.pdf do
        dump_tmp_filename = Rails.root.join('tmp',@supplier.cache_key)
        Dir.mkdir(dump_tmp_filename.dirname) unless File.directory?(dump_tmp_filename.dirname)
        save_pdf_to(dump_tmp_filename,@supplier)
        send_file(dump_tmp_filename, :type => :pdf, :disposition => 'attachment', :filename => "#{@supplier.razonsocial}.pdf")
        File.delete(dump_tmp_filename)
      end
    end
  end

  def new
    @supplier = current_company.suppliers.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @supplier }
    end
  end

  def edit
  end

  def create
    @supplier = Supplier.new(params[:supplier].update(:company_id => current_company.id))

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to(@supplier, :notice => 'Proveedor was successfully created.') }
        format.xml  { render :xml => @supplier, :status => :created, :location => @supplier }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @supplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @supplier.update_attributes(params[:supplier])
        format.html { redirect_to(@supplier, :notice => 'Proveedor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @supplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @supplier.destroy

    respond_to do |format|
      format.html { redirect_to(supplier_url) }
      format.xml  { head :ok }
    end
  end


def cuentacorriente
  @cuentacorriente = @supplier.comprobantes.order("fecha")
  
  respond_to do |format|
    format.html # .html.erb
    format.xml  { render :xml => @supplier }
    format.pdf { render :pdf => "cc_#{@supplier.id}",
                     :template => 'suppliers/cuentacorriente.html.erb',
                     :show_as_html => params[:debug].present?,      # allow debuging based on url param
                     :layout => 'pdf.html.erb',
                     :footer => { :right => "Reporte generado el #{l DateTime.current}" }
               }
  end
end

def list_accounts
  #begin
    @accounts = Account.all()

    respond_to do |format|
      format.html { redirect_to( clientes_url ) }
      format.xml  { head :ok }
    end
  #rescue ActiveResource::ResourceNotFound, ActiveResource::Redirection, ActiveResource::ResourceInvalid
  #  redirect_to("404.html")
  #ensure
    # redirect_to("404.html")
    # paso siempre por aca
  #end
end

protected 
# filtro general protejido
  def filter_supplier
    @supplier = Supplier.by_company(current_company).find( params[:id] )
  end
end