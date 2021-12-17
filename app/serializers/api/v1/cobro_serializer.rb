module Api 
    module V1 
        class CobroSerializer < ApplicationSerializer
            attributes :id,
                    #:id_cliente,
                    :cliente_id_api,
                    :dinero_cobrado ,
                    :dinero_a_cobrar,
                    :moneda,
                    :fecha_de_cobro
        end
    end 
end