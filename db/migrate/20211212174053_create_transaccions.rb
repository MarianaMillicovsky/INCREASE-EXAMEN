class CreateTransaccions < ActiveRecord::Migration[6.1]
  def change
    create_table :transaccions do |t|
      t.belongs_to :cliente 
      t.string :id_transaccion, unique: true
      t.string :monto, unique: false
      t.string :tipo, unique: false
      t.string :cliente_id_api

      #t.timestamps
    end
  end
end
