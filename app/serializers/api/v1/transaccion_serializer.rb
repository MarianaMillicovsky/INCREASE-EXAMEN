module Api  
    module V1
        class TransaccionSerializer < ApplicationSerializer
            attributes :id,
            #:cliente_id,
            :cliente_id_api,
            :id_transaccion,
            :monto,
            :tipo                      
        end
    end 
end
