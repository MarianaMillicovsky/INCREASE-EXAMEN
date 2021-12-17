require 'rails_helper'
url = "https://increase-transactions.herokuapp.com/file.txt"
RSpec.describe "Cobros", type: :request do
  describe "GET /cobros" do
    context 'url transactions api renders 200 status' do
      it "works! (now write some real specs)" do
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

        stub_request(:get, "https://increase-transactions.herokuapp.com/file.txt").
         with(
           headers: {
          'Accept'=>'*/*',
          'Authorization'=>'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm',
          'Host'=>'increase-transactions.herokuapp.com',
           }).
         to_return(status: 200, body: body, headers: {})

        stub_request(:get, "https://increase-transactions.herokuapp.com/clients/3a00b1c45a2f466f8b57f0f62fbcdc9e").
          with(
            headers: {
           'Accept'=>'*/*',
           'Authorization'=>'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm',
           'Host'=>'increase-transactions.herokuapp.com'
            }).
          to_return(status: 200, body: "", headers: {})

        stub_request(:get, "https://increase-transactions.herokuapp.com/clients/3a00b1c45a2f466f8b57f0f62fbcdc9t").
          with(
            headers: {
           'Accept'=>'*/*',
           'Authorization'=>'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm',
           'Host'=>'increase-transactions.herokuapp.com'
            }).
          to_return(status: 200, body: "", headers: {})
      
        expect {
          get api_v1_transaccions_path
        }.to change { Cobro.count }.from(0).to(2)

        get api_v1_clientes_path
        expect(Cobro.count).to eq(2) # se espera que se cachee la informacion, no se registran nuevos clientes repetidos
        
        expect {
          response.header['Content-Type'].to include 'application/json'
        }

        expect(Cobro.find_by(cliente_id_api: "3a00b1c45a2f466f8b57f0f62fbcdc9t").dinero_cobrado).to eq("0000191962362")
        expect(Cobro.find_by(cliente_id_api: "3a00b1c45a2f466f8b57f0f62fbcdc9t").dinero_a_cobrar).to eq("0000189081278")
        expect(Cobro.find_by(cliente_id_api: "3a00b1c45a2f466f8b57f0f62fbcdc9t").moneda).to eq("USD")
        expect(Cobro.find_by(cliente_id_api: "3a00b1c45a2f466f8b57f0f62fbcdc9t").fecha_de_cobro).to eq("21/12/2021")

        expect(Cobro.find_by(cliente_id_api: "3a00b1c45a2f466f8b57f0f62fbcdc9e").dinero_cobrado).to eq("0000209550033")
        expect(Cobro.find_by(cliente_id_api: "3a00b1c45a2f466f8b57f0f62fbcdc9e").dinero_a_cobrar).to eq("0000209276016")
        expect(Cobro.find_by(cliente_id_api: "3a00b1c45a2f466f8b57f0f62fbcdc9e").moneda).to eq("ARS")
        expect(Cobro.find_by(cliente_id_api: "3a00b1c45a2f466f8b57f0f62fbcdc9e").fecha_de_cobro).to eq("21/12/2021")

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
