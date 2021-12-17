module Api 
    module V1
        class TransaccionsController < ApplicationController
        before_action :get_data, only: [:index]

            # GET /filefiletransactions
            def index
                if Transaccion.count > 0 
                    render json: Transaccion.all, each_serializer: TransaccionSerializer,  status: :ok
                else 
                    Rails.cache.clear 
                    render json: "[couldn't fetch data]", status: :internal_server_error
                end
            end

        end  
    end
end
