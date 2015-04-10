class DocCommentsController < ApplicationController
    before_filter :signed_in_user, only: [:create, :destroy]
    def create
        @doc = Doc.find(params[:doc_id])
        @doc_comment = @doc.doc_comments.build(doc_comment_params)
        @doc_comment.doc = @doc
        @doc_comment.user = current_user
        @doc_comment.save
        redirect_to @doc
    end

    def destroy
        @doc_comment = DocComment.find(params[:id])
        @doc = @doc_comment.doc
        @doc_comment.destroy
        redirect_to @doc
    end
    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def doc_comment_params
            params.require(:doc_comment).permit(:doc_id, :doc_comment, :content, :user_id)
        end


end
