require 'spec_helper'

describe MoviesController do
  describe 'search for movies by director' do
    it 'should have a RESTful route for "find similar movies"' do
      Movie.stub('find_similar_movies')
      Movie.should_receive('find_similar_movies').with('Star Wars')
      get :similar, {:title => 'Star Wars'}
    end

    it 'should implement a controller method to receive the click on "Find Movies With Same Director", and grab the id (for example) of the current movie' do
      fake_results = [1, 2]
      Movie.stub('find_similar_movies').and_return(fake_results)
      get :similar, {:title => 'Star Wars'}
      assigns(:movies).should == fake_results
    end
  end
end

