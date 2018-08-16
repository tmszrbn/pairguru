require "rails_helper"

describe "Commenters requests", type: :request do
  let(:commenters) { create_list(:user, 15) }
  describe "top ten commenters list" do
    before :each do
      commenters.shuffle!
      @commenter_1st = ""
      @commenter_10th = ""
      @commenter_11th = ""
      commenters.shuffle.each do |commenter|
        create_list(:comment, commenter.id % 15, user_id: commenter.id)
        if commenter.id == 14
          @commenter_1st = commenter
        elsif commenter.id == 5
          @commenter_10th = commenter
        elsif commenter.id == 4
          @commenter_11th = commenter
        end
      end
    end
    it "displays 10 users with the most comments" do
      get commenters_top_ten_path
      expect(response.body).to match /.*<ul.*#{@commenter_1st.email}.*#{@commenter_10th.email}.*ul>.*/im
      expect(response.body).not_to match /(<ul.*#{@commenter_11th.email}.*ul>)/im
    end
  end
end
