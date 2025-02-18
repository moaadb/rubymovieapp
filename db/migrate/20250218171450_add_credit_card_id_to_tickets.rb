class AddCreditCardIdToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :credit_card_id, :integer
  end
end
