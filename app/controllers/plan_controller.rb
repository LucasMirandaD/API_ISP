class PlanController < ApplicationController
    before_action :check_token
       
        def index
            @plan = Plan.all
            render status:200 ,json: {isp: @plan}
        end
    
        def create 
            @isp = Isp.find_by(name_isp: params[:isp_plan])
  
            if @isp
                @plan = @isp.plans.create(
                name_plan: params[:name_plan],
                band_width: params[:band_width],
                simetric: params[:simetric]
                )
    
                if @plan.persisted?
                    render status: 200, json: { plan: @plan }
                  else
                    render status: 400, json: { message: @plan.errors.details }
                  end
                  
                else
                  render status: 404, json: { message: "ISP no encontrado" }
                end
            end

        private
    
        def plan_params
            params.permit(:name_plan,:band_width,:simetric,:isp_plan)
        end

    private
    def check_token
        token = request.headers["Authorization"].split(" ") #Tengo que usar split porque el front envía "Bearer token" y solo necesito el token.
        @client=Client.find_by(token: token[1])#En token[0] queda "Bearer"
        @isp=Isp.find_by(token: token[1])#En token[0] queda "Bearer"

        return if @client.present? or @isp.present?
        #dejar espacio despues de return para buena costumbre. Si la condicion de if se cumple, la 
        #funcion retorna. Sino sigue con render status
        render status: 401, json:{message: "Debe iniciar sesión con un usuario válido"}#Si llega a esta línea de código, significa que se ha introducido manualmente un token incorrecto en el front en lugar de seguir el procedimiento normal de inicio de sesión
        false #false necesario para que no se ejecute el action que ha llamado check_token como callback
    end
end
