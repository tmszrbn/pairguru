require "rails_helper"

RSpec.describe "movies/show", type: :view do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:comment) { build(:comment, body: nil) }
  let(:comments) { create_list(:comment, 10, movie_id: movie.id) }
  before :each do
    assign(:movie, movie)
    assign(:comment, comment)
    assign(:comments, comments)
  end
  context "when user is signed_in" do
    before :each do
      allow(view).to receive(:user_signed_in?).and_return true
      allow(view).to receive(:current_user).and_return user
    end
    it "lists all movie's comments" do
      render
      expect(rendered).to match /#{comments.map { |c| c.body }.join(".*")}/im
    end
    it "renders form for comment" do
      render
      expect(rendered).to match /<form.*(?=.*action="\/comments")(?=.*method="post").*form>/im
    end
    it "renders button for uncommenting if user has already commented on the movie" do
      com = Comment.create(movie_id: movie.id, user_id: user.id, body: "I can oncomment that")
      render
      expect(rendered).to match /<form.*(?=.*class="button_to")(?=.*action="\/comments\/#{com.id}")(?=.*method="post").*form>/im
    end
  end
end
