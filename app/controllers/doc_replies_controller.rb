class DocRepliesController < ApplicationController
    before_filter :signed_in_user, only: [:create, :destroy]
    def create
        @doc_comment = DocComment.find(params[:doc_comment_id])
        @doc_reply = @doc_comment.doc_replies.build(doc_reply_params)
        @doc_reply.doc_comment = @doc_comment
        @doc_reply.user = current_user
        @doc_reply.save
        redirect_to :back
    end

    def destroy
        @doc_reply = DocReply.find(params[:id])
        @doc_comment = @doc_reply.doc_comment
        @doc_reply.destroy
        redirect_to :back
      end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def doc_reply_params
            params.require(:doc_reply).permit(:doc_comment_id, :doc_reply, :content, :user_id)
        end


end