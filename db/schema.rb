# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_12_174738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clientes", force: :cascade do |t|
    t.string "cliente_id_api"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "job"
    t.string "country"
    t.string "address"
    t.string "zip_code"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cobros", force: :cascade do |t|
    t.bigint "cliente_id"
    t.string "dinero_cobrado", null: false
    t.string "dinero_a_cobrar", null: false
    t.string "moneda", null: false
    t.string "fecha_de_cobro", null: false
    t.string "cliente_id_api"
    t.string "aaa"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cliente_id"], name: "index_cobros_on_cliente_id"
  end

  create_table "transaccions", force: :cascade do |t|
    t.bigint "cliente_id"
    t.string "id_transaccion"
    t.string "monto"
    t.string "tipo"
    t.string "cliente_id_api"
    t.index ["cliente_id"], name: "index_transaccions_on_cliente_id"
  end

end
