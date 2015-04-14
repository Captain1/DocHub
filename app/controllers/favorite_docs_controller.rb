class FavoriteDocsController < ApplicationController
  def index
    # return an array [2,3,...]
    @favorite_docs_ids = Favorite.where(user_id:current_user.id).pluck(:favorited_id)
    @favorite_docs =Doc.all.where(id:@favorite_docs_ids).order("created_at DESC")
    .paginate(page: params[:page], per_page: 4)
    respond_to do |format|
      format.html
      format.json { render json: @favorite_docs }
    end
  end

  def create
    @doc = Doc.find(params[:doc_id] || params[:id]) 
    if Favorite.create(favorited: @doc, user: current_user)
      flash[:notice] = 'Doc has been favorited.'
      redirect_to :back
    else
      flash[:notice] = 'Something went wrong...'
      redirect_to :back
    end
  end

  def destroy
    @doc = Doc.find(params[:doc_id] || params[:id]) 
    Favorite.where(favorited_id: @doc.id, user_id:current_user.id).first.destroy
    redirect_to :back, notice:'Doc is no longer in favorites.'
  end
end
