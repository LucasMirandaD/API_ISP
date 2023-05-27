Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :client , param: :nickname , except:[:update, :destroy, :new, :edit] do
    member do
      post :login # /client/:nickname/login
    end
  end
    
  resources :isp , param: :name_isp , except:[:update, :destroy, :new, :edit] do
    member do
      post :login # /isp/:name_isp/login
    end
  end

  resources :request, :plan , except:[:update, :destroy, :new, :edit] do
  end




=begin
Para Client:

GET /client -> Muestra una lista de clientes
GET /client/:nickname -> Muestra los detalles de un cliente específico
POST /client -> Crea un nuevo cliente
POST /client/:nickname/login -> Realiza el inicio de sesión para un cliente específico
Para Isp:

GET /isp -> Muestra una lista de ISPs
GET /isp/:name -> Muestra los detalles de un ISP específico
POST /isp -> Crea un nuevo ISP
POST /isp/:name_isp/login -> Realiza el inicio de sesión para un ISP específico
Para Request:

GET /request -> Muestra una lista de solicitudes
GET /request/:id -> Muestra los detalles de una solicitud específica
POST /request -> Crea una nueva solicitud
Para Plan:

GET /plan -> Muestra una lista de planes
GET /plan/:id -> Muestra los detalles de un plan específico
POST /plan -> Crea un nuevo plan

=end 
end
