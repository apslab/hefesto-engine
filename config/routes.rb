Rails.application.routes.draw do
#  resources :empresas
  # resources :facturas, :as => "hefesto_facturas", :controller => 'hefesto/facturas'

  scope "/compras" do
    resources :facturas, :controller => 'hefesto/facturas'
    resources :notacreditos, :controller => 'hefesto/notacreditos'
    resources :recibos, :controller => 'hefesto/recibos'
    resources :facturanotacreditos, :controller => 'hefesto/facturanotacreditos'
    resources :facturarecibos, :controller => 'hefesto/facturarecibos'

    resources :suppliers, :path => "proveedores" do
      member do
        get 'list_accounts', :action => :list_accounts
        get 'cuentacorriente', :action => :cuentacorriente 
      end
       
      resources :facturas, :as => "hefesto_facturas", :controller => 'hefesto/facturas' do
        member do
          get 'print', :action => :imprimir 
        end
      end  

      resources :recibos, :as => "compra_recibos", :controller => 'hefesto/recibos'
      resources :notacreditos, :as => "compra_notacreditos", :controller => 'hefesto/notacreditos'
    end  
  end
end
