class IspController < ApplicationController
    before_action :check_token ,except: [:login, :create]#, only: [ :show,]

    def index
        @isp=Isp.all
        render status:200 ,json: {isp: @isp}
    end
    
    def show
        @isp=Isp.find_by(name_isp: params[:name_isp])
        @requests = @isp.requests.includes(:plan_isp, :isp)
        
        
        if @isp.present? and @requests.present?
            render status:200 ,json: {
                isp: @isp,
                requests: @requests}
            
        elsif @isp.present?
            render status:206 ,json: {isp: @isp , message: "El isp no tiene requests asociadas"}
        else
            render status:404 , json: {message: "no se encuentra el ISP #{params[:name_isp]}"}
        end
    end

    def login
        @isp=Isp.find_by(name_isp: params[:name_isp], password: params[:password])
        
        if @isp.present?
            render status:200 ,json: {isp: @isp}
        else
            render status:404 , json: {message: "no se encuentra el ISP #{params[:name_isp]}"}
        end
    end


    def create #poner privadas las funciones
        @isp = Isp.create(params.permit(:name_isp, :password))
 
        if @isp.persisted?
            render status:200 ,json: {isp: @isp}
        else 
            render status:400, json: {message: @isp.errors.details}
        end
    end

    def update   
        @isp=Isp.find_by(name_isp: params[:name_isp])

        if isp.present?
            if isp.update(isp_params)
                render status:200 ,json: {isp: isp}
            else 
                render status:400, json: {message: isp.errors.details}
            end
        else
            render status:404 , json: {message: "No se encuentra el ISP #{params[:id]}"}
        end
    end


    # def destroy

    #     @player = Player.find_by(nickname: params[:nickname])
        
    #     if @player.present? 
    #         @player.destroy
    #         render status:200 ,json: {message: "Se destruyo el jugador #{params[:id]}"}
    #     else
    #         render status:404 , json: {message: "No se encuentra el jugador #{params[:id]}"}
    #     end
    # end
    
    def login
        @isp=Isp.where(name_isp: params[:name_isp], password: params[:password])
        if @isp.present?
           render status: 200, json: {isp: @isp}
        else
           render status: 404, json: {message: "No existe el cliente o la contraseña es incorrecta."}
        end
   end

    def check_token
        token = request.headers["Authorization"].split(" ") #Tengo que usar split porque el front envía "Bearer token" y solo necesito el token.
        @isp=Isp.find_by(token: token[1])#En token[0] queda "Bearer"

        return if @isp.present?
        #dejar espacio despues de return para buena costumbre. Si la condicion de if se cumple, la 
        #funcion retorna. Sino sigue con render status
        render status: 401, json:{message: "Debe iniciar sesión con un usuario válido"}#Si llega a esta línea de código, significa que se ha introducido manualmente un token incorrecto en el front en lugar de seguir el procedimiento normal de inicio de sesión
        false #false necesario para que no se ejecute el action que ha llamado check_token como callback
    end
    
    private
    
    def isp_params
        params.permit(:name_isp, :password)
    end
end 
