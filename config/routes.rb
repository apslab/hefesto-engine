Rails.application.routes.draw do
  resources :suppliers do
    resources :facturas, :controller => 'hefesto/facturas'
    resources :recibos,  :controller => 'hefesto/recibos'
    resources :notacreditos, :controller => 'hefesto/notacreditos'
    resources :facturanotacreditos,  :controller => 'hefesto/facturanotacreditos'
    resources :facturarecibos, :controller => 'hefesto/facturarecibos'

    member do
      get 'list_accounts', :action => :list_accounts
      get 'cuentacorriente', :action => :cuentacorriente 
    end
  end
end