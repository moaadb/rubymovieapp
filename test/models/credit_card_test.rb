require "test_helper"

class CreditCardTest < ActiveSupport::TestCase

  setup do
    # Load in valid credit card fixture as a basis for all tests
    @credit_card = credit_cards(:v_card)
  end

  test "valid: create credit card" do
    t_card = @credit_card
    assert t_card.save()
  end

  test "invalid: create credit card without parameters" do
    t_card = CreditCard.new()
    assert_not t_card.save()
  end

  test "invalid: test nil card number for credit card instantiation" do
    t_card = @credit_card
    t_card.card_number = nil
    assert_not t_card.save()
  end

  test "invalid: test nil user ref for credit card instantiation" do
    t_card = @credit_card
    t_card.user_id = nil
    assert_not t_card.save()
  end

  test "invalid: test nil exp date for credit card instantiation" do
    t_card = @credit_card
    t_card.expiration_date = nil
    assert_not t_card.save()
  end

  test "invalid: incorrect credit card num string length" do
    t_card = @credit_card
    # String Length 15
    t_card.card_number = "123412341234123"
    assert_not t_card.save()
    # String Length 20
    t_card.card_number = "12341234123412341234"
    assert_not t_card.save()
    # Empty String
    t_card.card_number = ""
    assert_not t_card.save()
    # String Length 1
    t_card.card_number = "1"
    assert_not t_card.save()
  end

  test "invalid: credit card num string contains non digits" do
    t_card = @credit_card
    # Incorrect length and non-numeric
    t_card.card_number = "Whoa"
    assert_not t_card.save()
    # Non-Numeric, all alphabet
    t_card.card_number = "AAAAAAAAAAAHHHHH"
    assert_not t_card.save()
    # Non-alphanumeric
    t_card.card_number = "[]';[';.,]]][()]"
    assert_not t_card.save()
    # Alphanumeric
    t_card.card_number = "2345rtfe4ty5yhg"
    assert_not t_card.save()
    # Symbols and alphanumeric
    t_card.card_number = "34klk;'[p;olik]"
    assert_not t_card.save()
  end
end
