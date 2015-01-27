class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @attachment = Attachment.new
    @attachments = Attachment.latest.page(params[:page])
  end

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.create(attachment_params)
    @attachment.user = current_user
    @attachment.save
    
    respond_to do |format|
      format.html { redirect_to :attachments, notice: t('flash.created', model: Attachment.model_name.human) }
      format.json { 
        render json: { 
          path: @attachment.file.url,
          is_image: @attachment.image?,
          name: @attachment.file_file_name
        } 
      }
    end
  end

  def destroy
    Attachment.find(params[:id]).destroy
    redirect_to :attachments, notice: t('flash.destroyed', model: Attachment.model_name.human)
  end

  private
    def attachment_params
      params.require(:attachment).permit(:file)
    end
end
