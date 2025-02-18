class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:edit, :update, :new, :create, :destroy]
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created."
    else
      render :new
    end
  end

  def edit
    # @movie is set by the before_action (set_movie)
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: 'Movie was successfully deleted.'
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :genre, :duration, :language, :rating, :release_date)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_url, alert: "You are not authorized to perform this action."
    end
  end
end
