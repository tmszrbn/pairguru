class CommentersController < ApplicationController
  def top_ten
    @commenters = User.top_commenters
      .order("comments_count desc")
      .limit(10)
  end
end
