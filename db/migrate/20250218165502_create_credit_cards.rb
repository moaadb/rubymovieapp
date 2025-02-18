class CreateCreditCards < ActiveRecord::Migration[8.0]
  def change
    create_table :credit_cards do |t|
      t.string :card_number
      t.date :expiration_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
