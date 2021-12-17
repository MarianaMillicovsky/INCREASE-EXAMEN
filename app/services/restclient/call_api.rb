require 'rest-client'
require 'json'
class CallApi 

   # url = 'https://increase-transactions.herokuapp.com/file.txt'
   # bearer_token = 'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm'
    def self.get_file 
        begin 
            RestClient.get('https://increase-transactions.herokuapp.com/file.txt',
                        {:Authorization => 'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm'})
        rescue RestClient::ExceptionWithResponse => e
            e.response
            Rails.cache.clear
        end
    end

    def self.get_client_data(id_aux) 
        begin
            #binding.pry
            data_aux = RestClient.get("https://increase-transactions.herokuapp.com/clients/#{id_aux}",
            {:Authorization => 'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm'})
            unless (data_aux.body == "")
            data = JSON.parse(data_aux.body) 
            Cliente.last.update( "cliente_id_api": id_aux, "email": data["email"], 
                "first_name": data["first_name"], "last_name": data["last_name"], 
                "job": data["job"], "country": data["country"], "address": data["address"], 
                "zip_code": data["zip_code"], "phone": data["phone"])
            end
        rescue RestClient::ExceptionWithResponse => e
            e.response # y aniadir backround job para que reintente
        end   
    end
end