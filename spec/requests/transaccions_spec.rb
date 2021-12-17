require 'rails_helper'
url = "https://increase-transactions.herokuapp.com/file.txt"
RSpec.describe "Api::V1::Transaccions", type: :request do
  describe "GET /transaccions" do
    context 'url transactions api renders 200 status' do
      it "works! (now write some real specs)" do
        WebMock.reset!
        body = <<~DOC
        1cbecdcdcc5294696aa3a7db00a2879b3   001000019196236200000028810840000189081278
        213fda412cd5246c3a6446024f93008780000001371140     2
        2d56c5dd82bea4ef1ab6edda3fe2e18910000001043543     1
        33574eeba1b02462fa59d3e6f96aaf0cb0000000361560   2
        3e3bbb771f46147188318bb41b89b574c0000000091682   4
        4               202112213a00b1c45a2f466f8b57f0f62fbcdc9t
        1837495e3444b4c678f9dcc72a1cf64f0   000000020955003300000002740170000209276016
        2189c5b37005145d5bb1bc2e720829adc0000000731105     1
        3e3bbb771f46147188318bb41b89b574c0000000091682   4
        4               202112213a00b1c45a2f466f8b57f0f62fbcdc9e
        DOC

         stub_get1 = stub_request(:get, "https://increase-transactions.herokuapp.com/file.txt").
         with(
           headers: {
          'Accept'=>'*/*',
          'Authorization'=>'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm',
          'Host'=>'increase-transactions.herokuapp.com',
           }).
         to_return(status: 200, body: body, headers: {})

          stub_get2 = stub_request(:get, "https://increase-transactions.herokuapp.com/clients/3a00b1c45a2f466f8b57f0f62fbcdc9e").
          with(
            headers: {
           'Accept'=>'*/*',
           'Authorization'=>'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm',
           'Host'=>'increase-transactions.herokuapp.com'
            }).
          to_return(status: 200, body: "", headers: {})

          stub_get3 = stub_request(:get, "https://increase-transactions.herokuapp.com/clients/3a00b1c45a2f466f8b57f0f62fbcdc9t").
          with(
            headers: {
           'Accept'=>'*/*',
           'Authorization'=>'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm',
           'Host'=>'increase-transactions.herokuapp.com'
            }).
          to_return(status: 200, body: "", headers: {}) 
          
        expect {
          get api_v1_transaccions_path
        }.to change { Transaccion.count }.from(0).to(3)

        get api_v1_clientes_path
        expect(Transaccion.count).to eq(3) # se espera que se cachee la informacion, no se registran nuevos clientes repetidos
        
        expect {
          response.header['Content-Type'].to include 'application/json'
        }

        expect(Transaccion.find_by(id_transaccion: "13fda412cd5246c3a6446024f9300878").cliente_id_api).to eq("3a00b1c45a2f466f8b57f0f62fbcdc9t")
        expect(Transaccion.find_by(id_transaccion: "13fda412cd5246c3a6446024f9300878").monto).to eq("0000001371140")
        expect(Transaccion.find_by(id_transaccion: "13fda412cd5246c3a6446024f9300878").tipo).to eq("Rechazado")
        expect(Transaccion.find_by(id_transaccion: "d56c5dd82bea4ef1ab6edda3fe2e1891").cliente_id_api).to eq("3a00b1c45a2f466f8b57f0f62fbcdc9t")
        expect(Transaccion.find_by(id_transaccion: "d56c5dd82bea4ef1ab6edda3fe2e1891").monto).to eq("0000001043543")
        expect(Transaccion.find_by(id_transaccion: "d56c5dd82bea4ef1ab6edda3fe2e1891").tipo).to eq("Aprobado")
        expect(Transaccion.find_by(id_transaccion: "189c5b37005145d5bb1bc2e720829adc").cliente_id_api).to eq("3a00b1c45a2f466f8b57f0f62fbcdc9e")
        expect(Transaccion.find_by(id_transaccion: "189c5b37005145d5bb1bc2e720829adc").monto).to eq("0000000731105")
        expect(Transaccion.find_by(id_transaccion: "189c5b37005145d5bb1bc2e720829adc").tipo).to eq("Aprobado")

        expect(response).to have_http_status(200)

        get api_v1_clientes_path
        expect(Cliente.count).to eq(2)
        expect {
          response.header['Content-Type'].to include 'application/json'
         }

        get api_v1_clientes_path
        expect(Cobro.count).to eq(2)
        expect {
          response.header['Content-Type'].to include 'application/json'
         }

      end
    end

  end
end
