require "rails_helper"

describe Movie do
  it 'validates using TitleBracketsValidator' do
    movie = Movie.create(title: '{{lskdjf')
    expect(movie.errors[:title].include? "Should have matching brackets").to be
  end
end
