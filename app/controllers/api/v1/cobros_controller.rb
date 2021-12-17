module Api
    module V1
        class CobrosController < ApplicationController
        before_action :get_data, only: [:index]

            # GET /filefiletransactions
            def index
                if Cobro.count > 0
                    render json: Cobro.all, each_serializer: CobroSerializer, status: :ok 
                else 
                    Rails.cache.clear 
                    render json: "[couldn't fetch data]", status: :internal_server_error 
                end
            end

        end 
    end 
end
