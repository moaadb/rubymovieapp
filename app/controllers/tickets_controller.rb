class TicketsController < ApplicationController
  before_action :authorized
  before_action :set_ticket, only: [:edit, :update, :destroy]
  before_action :authorize_admin, only: [:edit, :update, :destroy]

  def index
    if current_user.admin?
      @tickets = Ticket.includes(:show, :user).order(created_at: :desc)
    else
      @tickets = current_user.tickets.includes(:show).order(created_at: :desc)
    end

    # In case @tickets is nil, initialize it as an empty array
    @tickets ||= []
  end

  def new
    if current_user.admin? && params[:show_id].blank?
      @ticket = Ticket.new
    else
      @show = Show.find(params[:show_id])
      @ticket = @show.tickets.build
    end
  end

  def create
    if current_user.admin?
      @show = Show.find(ticket_params[:show_id]) # Admin selects the show from the form
      @ticket = @show.tickets.build(ticket_params)
      @ticket.user = User.find(ticket_params[:user_id])
    else
      @show = Show.find(ticket_params[:show_id]) # Regular users book from a specific show page
      @ticket = @show.tickets.build(ticket_params)
      @ticket.user = current_user

      # Ensure a credit card is selected for regular users
      if ticket_params[:credit_card_id].blank?
        redirect_to new_ticket_path(show_id: @show.id), alert: "A credit card must be selected to book the ticket."
        return
      end
    end

    if @show.movie.release_date > Date.today
      redirect_to movie_show_path(@show.movie, @show), alert: "Tickets for this movie are not available yet as the movie hasn't been released."
      return
    end

    if @show.seats_available > 0
      @ticket.status = "Booked"

      if @ticket.save
        @show.update(seats_available: @show.seats_available - 1)

        redirect_to movie_shows_path(@show.movie), notice: "Your ticket has been booked successfully!"
      else
        render :new
      end
    else
      redirect_to movie_show_path(@show.movie, @show), alert: "Sorry, no seats are available for this show."
    end
  end

  # Edit ticket (Admin only)
  def edit
    # Only admins should be able to edit tickets, so no need for extra check here as the view will handle that.
  end

  # Update ticket (Admin only)
  def update
    old_show = @ticket.show

    if @ticket.update(ticket_params)
      if @ticket.show != old_show
        old_show.update(seats_available: old_show.seats_available + 1) # Increment for old show
        @ticket.show.update(seats_available: @ticket.show.seats_available - 1) # Decrement for new show
      end

      redirect_to user_tickets_path(current_user), notice: "Ticket was successfully updated."
    else
      render :edit, alert: "There was an issue updating the ticket."
    end
  end

  def cancel
    @ticket = current_user.tickets.find(params[:id])
    @show = @ticket.show

    if @ticket.update(status: "Cancelled")
      # Increase available seats for the show
      @show.update(seats_available: @show.seats_available + 1)
      redirect_to user_tickets_path(current_user), notice: "Your ticket has been cancelled and the seat is now available."
    else
      redirect_to user_tickets_path(current_user), alert: "There was an issue cancelling your ticket."
    end
  end

  def destroy
    if current_user.admin?
      @show = @ticket.show
      if @ticket.destroy
        # Increment the seats_available for the show when the ticket is deleted
        @show.update(seats_available: @show.seats_available + 1)

        redirect_to user_tickets_path(current_user), notice: "Ticket was successfully deleted."
      else
        redirect_to user_tickets_path(current_user), alert: "There was an issue deleting the ticket."
      end
    else
      redirect_to root_path, alert: "You are not authorized to delete this ticket."
    end
  end

  private

  def ticket_params
    if current_user.admin?
      params.require(:ticket).permit(:user_id, :show_id)
    else
      params.require(:ticket).permit(:user_id, :credit_card_id, :show_id)
    end
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
    if current_user.admin? && @ticket.user != current_user
      # Make sure admin can edit any ticket, not just their own
      # You can adjust this condition based on your requirements
    end
  end

  def authorize_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
