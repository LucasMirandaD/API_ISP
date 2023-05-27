class RequestController < ApplicationController
    
    before_action :check_token
    
    def show
        @request = Request.find_by(acceptRequest: false)
        
        if @request.present?
            render status:200 ,json: {clients: @request}
        else
            render status:404 , json: {message: "no se hay rechazadas"}
        end
    end

    def create
        @client = Client.find_by(nickname: params[:nickname])
        @isp = Isp.find_by(name_isp: params[:name_isp])
        @plan = Plan.find_by(name_plan: params[:name_plan])
      
        if @client && @isp && @plan
          @request = @client.requests.create(
            numberRequest: SecureRandom.uuid,
            plan: @plan,
            isp: @isp
          )
      
          if @request.persisted?
            render status: 200, json: { request: @request }
          else
            render status: 400, json: { message: @request.errors.details }
          end
        else
          render status: 404, json: { message: "Cliente, ISP o plan no encontrado" }
        end
      end
      

    def check_token
        token = request.headers["Authorization"].split(" ") #Uso split para separar el token de las comillas y solo necesito el token.
        @client=Client.find_by(token: token[1])#En token[0] queda "Bearer"

        return if @client.present?
       
        render status: 401, json:{message: "Debe iniciar sesión con un usuario válido"}#Si llega a esta línea de código, significa que se ha introducido manualmente un token incorrecto en el front en lugar de seguir el procedimiento normal de inicio de sesión
        false #false necesario para que no se ejecute el action que ha llamado check_token como callback
    end


end
