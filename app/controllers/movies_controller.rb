class MoviesController < ApplicationController
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    redirect = false
    
    if params[:sort_by]
      session[:sort_by] = params[:sort_by]
      @sort_by = params[:sort_by]
    elsif session[:sort_by]
      @sort_by = session[:sort_by]
    else
      @sort_by = ""
      redirect = true
    end
    
    if params[:commit] == "Refresh" and params[:ratings].nil?
      @ratings = session[:ratings]
    elsif params[:ratings]
      @ratings = params[:ratings]
      session[:ratings] = params[:ratings]
    else
      @ratings = nil
      redirect = true
    end
    
    if redirect
      flash.keep
      if (session[:ratings].nil?)
        redirect_to movies_path(:sort_by=>session[:sort_by], :ratings=>1)
      else
        redirect_to movies_path(:sort_by=>session[:sort_by], :ratings=>session[:ratings])
      end
      return
    end
    
    #@sort_by = params[:sort_by]
    #@movies = Movie.order(params[:sort_by])
    
    #if params[:ratings]
    #  @movies = Movie.where(:rating=>params[:ratings].keys).order(params[:sort_by])
    #end
    
    #@ratings = params[:ratings]
    if @ratings and @sort_by
      @movies = Movie.where(:rating=>@ratings.keys).order(@sort_by)
    elsif @ratings
      @movies = Movie.where(:rating=>@ratings.keys)
    elsif @sort_by
      @movies = Movie.order(@sort_by)
    #else
    #  @movies = Movie.all
    end
    
    if !@ratings
      @ratings = Hash.new
    end
    #@movies = Movie.all
    if params[:ratings] and params[:sort_by]
      @movie = Movie.where(:rating=>params[:ratings].keys).order(params[:sort_by])
    end
      
    
    @sort_column = params[:sort_by]
    
    @set_ratings = params[:set_ratings]
    
    if !@set_ratings
      @set_ratings = Hash.new
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
end
