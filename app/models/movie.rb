class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.find_similar_movies(movie_title)
    movies = []
    if movie_title.is_a?(String)
      movie = find_by_title(movie_title)

      if !movie.nil?
        dr = movie.director

        if dr.is_a?(String) and dr.length > 1
          movies = find_all_by_director(dr)
        end
      end
    end

    movies
  end
end
