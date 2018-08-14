require "rails_helper"

describe Movie do
  it 'validates using TitleBracketsValidator' do
    a = Movie.create(title: '{{lskdjf')
    expect(a.errors[:title].include? "Should have matching brackets").to be
  end
end
