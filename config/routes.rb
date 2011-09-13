Rails.application.routes.draw do
  scope "/compras" do
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

      resources :recibos, :as => "hefesto_compra_recibos", :controller => 'hefesto/recibos'
      resources :notacreditos, :as => "hefesto_compra_notacreditos", :controller => 'hefesto/notacreditos'
      resources :facturanotacreditos, :as => "hefesto_compra_facturanotacreditos", :controller => 'hefesto/facturanotacreditos'
      resources :facturarecibos, :as => "hefesto_compra_facturarecibos", :controller => 'hefesto/facturarecibos'
    end
  end
end