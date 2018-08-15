byebug_histor;;;y
.byebug_history
.byebug_history
.byebug_history
.byebug_history
.byebug_history
.byebug_history
.byebug_history(config.rxArray
                
                
                itinspectu )
require "rails_helper"

describe "Genres requests", type: :request do
  let!(:genres) { create_list(:genre, 5, :with_movies) }

  describe "genre list" do
    it "displays only related movies" do
      visit "/genres/" + genres.sample.id.to_s + "/movies"
      expect(page).to have_selector("table tr", count: 5)
    end
  end
end
