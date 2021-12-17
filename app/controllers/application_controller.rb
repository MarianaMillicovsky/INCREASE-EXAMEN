class ApplicationController < ActionController::API
    require 'rest-client'
    require 'json'
    require_relative '../services/restclient/call_api.rb'

    def get_data
        #binding.pry
        Rails.cache.fetch("my_file", expires_in: 10.minutes) do
            Cliente.delete_all
            Transaccion.delete_all 
            Cobro.delete_all
            my_file = CallApi.get_file()  
            
            unless my_file == 0
                Rails.cache.write('my_file', my_file.body, :expires => 10.minutes)

                aux_cliente_id = nil   
                transacciones = []
                tipo = nil
                new_client = nil
                dinero_cobrado = nil 
                dinero_a_cobrar = nil
                moneda = nil
                fecha_de_cobro = nil

                Rails.cache.read('my_file').each_line do |line|
                    case line[0]
                    when '1'
                    # binding.pry
                        new_client = Cliente.create()
                        aux_cliente_id = new_client.id
                        if line[(36)..(38)] == "000"
                            moneda = "ARS" 
                        else  
                            moneda = "USD"
                        end
                        dinero_cobrado = line[(39)..(39+12)]   
                        dinero_a_cobrar = line[(65)..(65+12)]
                        #binding.pry
                    when '2'  
                        if line[51] == "1"  
                            tipo = "Aprobado" 
                        else 
                            tipo = "Rechazado" 
                        end  
                        transacciones.push({ id_transaccion: line[(1..(1+31))], cliente_id: aux_cliente_id,
                        monto: line[(33)..(33+12)], tipo: tipo})
                    when '4'
                        id_aux = line[(24)..(24+31)]
                        fc = line[(16)..(16+7)]
                        fecha_de_cobro = "#{fc[6..7]}/#{fc[4..5]}/#{fc[0..3]}"

                        Cobro.create(cliente_id: aux_cliente_id, dinero_cobrado: dinero_cobrado, 
                        dinero_a_cobrar: dinero_a_cobrar, moneda: moneda,
                        fecha_de_cobro: fecha_de_cobro,cliente_id_api: id_aux)

                        transacciones.each {|x| x[:cliente_id_api]=id_aux}
                        Transaccion.insert_all!(transacciones)
                        transacciones = []
                        Cliente.last.cliente_id_api = id_aux
                        CallApi.get_client_data(id_aux)    
                    end  
                end  
            end
         end   
    end  
end
