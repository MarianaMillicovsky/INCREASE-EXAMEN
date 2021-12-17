module Api 
    module V1
        class ClientesController < ApplicationController
          before_action :get_data, only: [:index]
            
          # GET /filefiletransactions
            def index
                if Cliente.count > 0 
                    render json: Cliente.all, each_serializer: ClienteSerializer, status: :ok
                else 
                    Rails.cache.clear 
                    render json: "[couldn't fetch data]", status: :internal_server_error 
                end
            end

      end  
    end 
end
