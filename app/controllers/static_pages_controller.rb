class StaticPagesController < ApplicationController
  def home
  	if signed_in?
        @micropost  = current_user.microposts.build
        @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
        @doc_comment = current_user.doc_comments.build
        @doc_feed_items = current_user.doc_feed.paginate(page: params[:page], per_page: 5)                        
    end
  end

  def help
  end

  def contact
  end
end
