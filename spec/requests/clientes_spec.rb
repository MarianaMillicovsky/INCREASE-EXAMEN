require 'rails_helper'
url = "https://increase-transactions.herokuapp.com/file.txt"
RSpec.describe "Clientes", type: :request do
  #WebMock.allow_net_connect! 
  describe "GET /clientes" do
    context 'url transactions api renders 200 status' do
      it "works! (now write some real specs)" do
        body = <<~DOC
        19c76cc8c37b3424ca5a6e8acd88c2250   001000017259015800000027565340000169833624
        213fda412cd5246c3a6446024f93008780000001371140     2
        33574eeba1b02462fa59d3e6f96aaf0cb00000/home/mariana/in/spec/requests/clientes_spec.rb00361560   2
        3e3bbb771f46147188318bb41b89b574c0000000091682   4
        4               2022010346ebdf4844d14d62a7a627c088b074cb
        1b6b4d088f7d54f4ba5bcdba134988529   000000004089582800000002281310000040667697
        2c5db1a59b1334b7f9fae252bd4e551d80000002417067     1
        4               20211221999d327c3ae44a599906a68be556f556
        DOC

        body_client1 = <<~DOC
        {"id":"46ebdf4844d14d62a7a627c088b074cb","email":"clarence@brakus.co",
        "first_name":"Romona","last_name":"Daugherty","job":"Global Facilitator",
        "country":"Slovenia","address":"542 Edwin Mount",
        "zip_code":"94696-5848","phone":"(651) 521-6519"}
        DOC

        body_client2 = <<~DOC
        {"id":"999d327c3ae44a599906a68be556f556","email":"patricia_nader@botsfordhyatt.org",
        "first_name":"Starr","last_name":"DuBuque","job":"Dynamic Advertising Manager",
        "country":"Australia","address":"4898 Alba Dalef",
        "zip_code":"77534","phone":"467.839.3213"}
        DOC

        stub_request(:get, "https://increase-transactions.herokuapp.com/file.txt").
         with(
           headers: {
          'Accept'=>'*/*',
          'Authorization'=>'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm',
          'Host'=>'increase-transactions.herokuapp.com',
           }).
         to_return(status: 200, body: body, headers: {})

        stub_request(:get, "https://increase-transactions.herokuapp.com/clients/46ebdf4844d14d62a7a627c088b074cb").
          with(
            headers: {
           'Accept'=>'*/*',
           'Authorization'=>'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm',
           'Host'=>'increase-transactions.herokuapp.com'
            }).
          to_return(status: 200, body: body_client1, headers: {})

        stub_request(:get, "https://increase-transactions.herokuapp.com/clients/999d327c3ae44a599906a68be556f556").
          with(
            headers: {
           'Accept'=>'*/*',
           'Authorization'=>'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm',
           'Host'=>'increase-transactions.herokuapp.com'
            }).
          to_return(status: 200, body: body_client2, headers: {})

      expect {
        get api_v1_clientes_path
      }.to change { Cliente.count }.from(0).to(2)

      get api_v1_clientes_path
      expect(Cliente.count).to eq(2) # se espera que se cachee la informacion, no se registran nuevos clientes repetidos
      
      expect {
        response.header['Content-Type'].to include 'application/json'
      }

      expect(Cliente.find_by(cliente_id_api: "46ebdf4844d14d62a7a627c088b074cb").email).to eq("clarence@brakus.co")
      expect(Cliente.find_by(cliente_id_api: "46ebdf4844d14d62a7a627c088b074cb").first_name).to eq("Romona")
      expect(Cliente.find_by(cliente_id_api: "46ebdf4844d14d62a7a627c088b074cb").last_name).to eq("Daugherty")
      expect(Cliente.find_by(cliente_id_api: "46ebdf4844d14d62a7a627c088b074cb").job).to eq("Global Facilitator")
      expect(Cliente.find_by(cliente_id_api: "46ebdf4844d14d62a7a627c088b074cb").country).to eq("Slovenia")
      expect(Cliente.find_by(cliente_id_api: "46ebdf4844d14d62a7a627c088b074cb").address).to eq("542 Edwin Mount")
      expect(Cliente.find_by(cliente_id_api: "46ebdf4844d14d62a7a627c088b074cb").zip_code).to eq("94696-5848")
      expect(Cliente.find_by(cliente_id_api: "46ebdf4844d14d62a7a627c088b074cb").phone).to eq("(651) 521-6519")

      expect(Cliente.find_by(cliente_id_api: "999d327c3ae44a599906a68be556f556").email).to eq("patricia_nader@botsfordhyatt.org")
      expect(Cliente.find_by(cliente_id_api: "999d327c3ae44a599906a68be556f556").first_name).to eq("Starr")
      expect(Cliente.find_by(cliente_id_api: "999d327c3ae44a599906a68be556f556").last_name).to eq("DuBuque")
      expect(Cliente.find_by(cliente_id_api: "999d327c3ae44a599906a68be556f556").job).to eq("Dynamic Advertising Manager")
      expect(Cliente.find_by(cliente_id_api: "999d327c3ae44a599906a68be556f556").country).to eq("Australia")
      expect(Cliente.find_by(cliente_id_api: "999d327c3ae44a599906a68be556f556").address).to eq("4898 Alba Dalef")
      expect(Cliente.find_by(cliente_id_api: "999d327c3ae44a599906a68be556f556").zip_code).to eq("77534")
      expect(Cliente.find_by(cliente_id_api: "999d327c3ae44a599906a68be556f556").phone).to eq("467.839.3213")

      expect(response).to have_http_status(200)

      end
    end

  end
end