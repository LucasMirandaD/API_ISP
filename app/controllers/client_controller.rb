class ClientController < ApplicationController

    before_action :check_token ,except: [:login, :create]#, only: [ :show,]

    def index
        @client = Client.all
        render status:200 ,json: {clients: @client}
    end
    
    def show
        @client = Client.find_by(nickname: params[:nickname])
        
        if @client.present?
            render status:200 ,json: {clients: @client}
        else
            render status:404 , json: {message: "no se encuentra el cliente #{params[:nickname]}"}
        end
    end

    def login
        @client = Client.find_by(nickname: params[:nickname], password: params[:password])
        
        if @client.present?
            render status:200 ,json: {client: @client}
        else
            render status:404 , json: {message: "no se encuentra el cliente #{params[:nickname]}"}
        end
    end


    def create #poner privadas las funciones
        @client = Client.create(client_params)

        if @client.persisted?
            render status:200 ,json: {client: @client}
        else 
            render status:400, json: {message: @client.errors.details}
        end
    end

    def update   
        client = Client.find_by(nickname: params[:nickname])

        if client.present?
            if client.update(client_params)
                render status:200 ,json: {client: client}
            else 
                render status:400, json: {message: client.errors.details}
            end
        else
            render status:404 , json: {message: "No se encuentra el jugador #{params[:id]}"}
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
        @client=Client.where(nickname: params[:nickname], password: params[:password])
        if @client.present?
           render status: 200, json: {client: @client}
        else
           render status: 404, json: {message: "No existe el cliente o la contraseña es incorrecta."}
        end
   end

    def check_token
        token = request.headers["Authorization"].split(" ") #Tengo que usar split porque el front envía "Bearer token" y solo necesito el token.
        @client=Client.find_by(token: token[1])#En token[0] queda "Bearer"

        return if @client.present?
        #dejar espacio despues de return para buena costumbre. Si la condicion de if se cumple, la 
        #funcion retorna. Sino sigue con render status
        render status: 401, json:{message: "Debe iniciar sesión con un usuario válido"}#Si llega a esta línea de código, significa que se ha introducido manualmente un token incorrecto en el front en lugar de seguir el procedimiento normal de inicio de sesión
        false #false necesario para que no se ejecute el action que ha llamado check_token como callback
    end
    
    private
    
    def client_params
        params.permit(:name,:lastname,:password,:nickname)
    end

end
 