module Api 
    module V1
        class ClienteSerializer < ApplicationSerializer
            attributes #:id,
                    :cliente_id_api,
                    :email,
                    :first_name,
                    :last_name,
                    :job,
                    :country,
                    :address,
                    :zip_code,
                    :phone
        end 
    end 
end
