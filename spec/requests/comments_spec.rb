require "rails_helper"

describe "Comments requests", type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:movie) { create(:movie) }

  describe "create comment" do
    context "user is logged in" do
      before :each do
        post user_session_path, params: { user: { email: user.email,
                                                  password: user.password } }
        post comments_path, params: { comment: { user_id: user.id,
                                                 movie_id: movie.id,
                                                 body: "Too darn good" } }
      end
      it "creates new comment" do
        expect(Comment.count).to eq 1
      end
      it "redirects to the movie's page" do
        expect(response).to redirect_to movie_path(id: movie.id)
      end
    end

    context "user is not logged in" do
      before :each do
        post comments_path, params: { comment: { user_id: user.id,
                                                 movie_id: movie.id,
                                                 body: "Too darn good" } }
      end
      it "redirects to the logging page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "destroy comment" do
    context "user is logged in" do
      before :each do
        comment = Comment.create user_id: user.id, movie_id: movie.id, body: "Delete it!"
        post user_session_path, params: { user: { email: user.email,
                                                  password: user.password } }
        delete comment_path(id: comment.id)
      end
      it "lets user to delete comment" do
        expect(Comment.count).to eq 0
      end
    end

    context "current user is not the same as the comment's author" do
      before :each do
        comment = Comment.create user_id: user.id, movie_id: movie.id, body: "Delete it!"
        post user_session_path, params: { user: { email: user2.email,
                                                  password: user2.password } }
        delete comment_path(id: comment.id)
      end
      it "redirects back" do
        expect(Comment.count).to eq 1
        expect(response).to redirect_to root_path
      end
    end
  end
end
