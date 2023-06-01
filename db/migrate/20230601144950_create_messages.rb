class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|

      t.string :title
      t.string :phone, index: true
      t.text :messages
      t.string :whatsapp_link
      t.string :reference, index: { unique: true }

      t.timestamps
    end
  end
end
