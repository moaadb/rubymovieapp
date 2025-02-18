class ShowsController < ApplicationController
  before_action :set_movie, only: [:index, :new, :create, :show, :edit, :update, :destroy] # Added :edit and :update
  before_action :set_show, only: [:show, :edit, :update, :destroy] # Added :edit and :update
  before_action :check_movie_release_date, only: [:index, :show]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy] # Allow admin for edit and update

  def index
    @shows = @movie.shows
  end

  def new
    @show = @movie.shows.build
  end

  def create
    @show = @movie.shows.build(show_params)
    if @show.save
      redirect_to movie_shows_path(@movie), notice: "Showtime successfully created."
    else
      render :new
    end
  end

  def show
    # @show is set by the before_action (set_show)
  end

  def edit
    # @show is set by the before_action (set_show)
  end

  def update
    if @show.update(show_params)
      redirect_to movie_show_path(@movie, @show), notice: "Showtime successfully updated."
    else
      render :edit
    end
  end
  def destroy
    @show.destroy
    redirect_to movie_shows_path(@movie), notice: "Showtime successfully deleted."
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])  # Find movie by movie_id param in the URL
  end

  def set_show
    @show = @movie.shows.find(params[:id])
  end

  def show_params
    params.require(:show).permit(:date, :time, :seats_available, :ticket_price)
  end

  def check_movie_release_date
    if @movie.release_date > Date.today
      redirect_to movies_path, notice: "This movie hasn't been released yet. Showtimes are not available."
    end
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_url, alert: "You are not authorized to perform this action."
    end
  end
end
