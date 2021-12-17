class CreateClientes < ActiveRecord::Migration[6.1]
  def change
    create_table :clientes do |t|
      t.string :cliente_id_api
      t.string :email 
      t.string :first_name
      t.string :last_name 
      t.string :job 
      t.string :country 
      t.string :address 
      t.string :zip_code 
      t.string :phone

      t.timestamps
    end
  end
end
