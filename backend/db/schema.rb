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

ActiveRecord::Schema[8.0].define(version: 2025_07_01_025837) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "compras", force: :cascade do |t|
    t.string "status", default: "pendente", null: false
    t.bigint "usuario_id", null: false
    t.bigint "instituicao_id", null: false
    t.decimal "valor_total", precision: 10, scale: 2, null: false
    t.decimal "valor_estimado", precision: 10, scale: 2, null: false
    t.integer "qtd_itens", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instituicao_id"], name: "index_compras_on_instituicao_id"
    t.index ["usuario_id"], name: "index_compras_on_usuario_id"
  end

  create_table "instituicoes", force: :cascade do |t|
    t.string "nome", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.bigint "compra_id", null: false
    t.bigint "produto_id", null: false
    t.integer "quantidade", null: false
    t.decimal "valor", precision: 10, scale: 2, null: false
    t.boolean "comprado", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compra_id"], name: "index_items_on_compra_id"
    t.index ["produto_id"], name: "index_items_on_produto_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.string "nome", null: false
    t.string "marca"
    t.string "categoria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true
  end

  add_foreign_key "compras", "instituicoes"
  add_foreign_key "compras", "usuarios"
  add_foreign_key "items", "compras"
  add_foreign_key "items", "produtos"
end
