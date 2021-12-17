class CreateCobros < ActiveRecord::Migration[6.1]
  def change
    create_table :cobros do |t|
      t.belongs_to :cliente
      t.string :dinero_cobrado, null: false 
      t.string :dinero_a_cobrar, null: false
      t.string :moneda, null: false
      t.string :fecha_de_cobro, null: false 
      t.string :cliente_id_api
      t.string :aaa

      t.timestamps
    end
  end
end
