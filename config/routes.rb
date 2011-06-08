Rails.application.routes.draw do
  resources :empresas

  resources :facturanotacreditos

  resources :facturarecibos

  resources :notacreditos

  resources :recibos

  resources :suppliers do 
    resources :facturas do
      member do
        get 'print', :action => :imprimir 
      end
    end  
    resources :recibos
    resources :notacreditos
    member do
      get 'list_accounts', :action => :list_accounts

      get 'cuentacorriente', :action => :cuentacorriente 
    end
  end  
    
  resources :facturas do
    resources :facturadetalles, :only => [:new, :create, :index, :destroy, :edit]
  end
end
