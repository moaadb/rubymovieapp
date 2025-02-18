class CreditCardsController < ApplicationController
  before_action :set_user
  before_action :authorize_non_admin, only: [:new, :create]
  before_action :authorize_user

  def new
    @credit_card = @user.credit_cards.build
  end

  def create
    @credit_card = @user.credit_cards.build(credit_card_params)
    if @credit_card.save
      redirect_to user_credit_cards_path(@user), notice: "Credit card added successfully."
    else
      render :new
    end
  end

  def destroy
    @credit_card = @user.credit_cards.find(params[:id])
    @credit_card.destroy
    redirect_to user_credit_cards_path(@user), notice: "Credit card removed."
  end

  private

  def set_user
    @user = current_user  # Assuming you are using authentication
  end

  def credit_card_params
    params.require(:credit_card).permit(:card_number, :expiration_date)
  end

  def authorize_non_admin
    if current_user.admin?
      redirect_to user_credit_cards_path(@user), alert: "Admins cannot add credit cards to their profiles."
    end
  end

  def authorize_user
    # Ensure the current_user is the same as the user whose credit cards are being viewed
    unless current_user == @user
      redirect_to root_path, notice: "You can't view other users' credit cards."
    end
  end
end
