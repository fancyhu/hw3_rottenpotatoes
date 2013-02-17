require 'spec_helper'

describe Movie do
  describe 'search for movies by director' do
    it 'should check a model method in the Movie model to find movies whose director matches that of the current movie.' do
      Movie.create!(:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25')
      Movie.create!(:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25')
      Movie.create!(:title => 'Alien', :rating => 'R', :director => '', :release_date => '1979-05-25')
      Movie.create!(:title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11')
      ret = Movie.find_similar_movies('Star Wars').collect { |movie| movie.id }
      ret.should == [1, 4]
    end

    it 'should check a model method in the Movie model to find movies whose director matches that of the current movie (Sad path).' do
      Movie.create!(:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25')
      Movie.create!(:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25')
      Movie.create!(:title => 'Alien', :rating => 'R', :director => '', :release_date => '1979-05-25')
      Movie.create!(:title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11')
      Movie.find_similar_movies(nil).should == []
      Movie.find_similar_movies('').should == []
      Movie.find_similar_movies('Alien').should == []
      Movie.find_similar_movies('What a f****** movie').should == []
    end
  end

end

