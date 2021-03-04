class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :unit_price

      t.timestamps
    end
    execute "ALTER SEQUENCE items_id_seq MINVALUE 2484 OWNED BY items.id START WITH 2484 RESTART 2484;"
  end
end
