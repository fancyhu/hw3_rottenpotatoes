require 'spec_helper'

describe MoviesController do
  describe 'list movies' do
    it 'should have a RESTful route for home page' do
      Movie.should_receive('find_all_by_rating')
      get :index, {:order => :title, :ratings => {:PG => '1', :R => '1'}}
      get :index, {:order => :title, :ratings => {:PG => '1', :R => '1'}}
      get :index
    end
  end

  describe 'list movies and redirect' do
    it 'should have a RESTful route for home page' do
      get :index, {:ratings => {}}
      response.should redirect_to({:ratings => {:G => 'G', :PG => 'PG', 'PG-13' => 'PG-13', 'NC-17' => 'NC-17', :R => 'R'}})
    end
  end


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

  describe 'delete a movie' do
    it 'should delete a movie' do
      Movie.should_receive('find').with('1').and_return(Movie.new(:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'))
      delete :destroy, :id => '1'
    end
  end

  describe 'add a movie' do
    it 'should add a movie' do
      Movie.should_receive('create!').with({'title' => 'Star Wars', 'rating' => 'PG', 'director' => 'George Lucas', 'release_date' => '1977-05-25'}).
        and_return(Movie.new(:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'))
      post :create, {:movie => {:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'}}
    end
  end

  describe 'edit a movie' do
    it 'should edit a movie' do
      Movie.should_receive('find').with('1').and_return(Movie.new(:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'))
      get :edit, :id => '1'
    end
  end

  describe 'update a movie' do
    it 'should update a movie' do
      Movie.should_receive('find').with('1').and_return(Movie.new(:title => 'Star Wars'))
      put :edit, {:id => '1', :movie => {:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'}}
    end
  end

  describe 'new movie page' do
    it 'should new movie page' do
      get :new
      response.should render_template('new')
    end
  end

  describe 'show a movie' do
    it 'should show a movie' do
      Movie.should_receive('find').with('1').and_return(Movie.new(:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'))
      get :show, :id => '1'
    end
  end

end

