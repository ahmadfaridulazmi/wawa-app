class MessagesController < ApplicationController

  before_action :load_message, only: %i(show update)

  def index
    @messages = Message.all
    render json: @messages
  end

  def show
    render json: @message
  end

  def update

  end

  def shorten
    message = Message.find_by(reference: params[:reference])
    redirect_to message.full_whatsapp_url, allow_other_host: true
  end

  private

  def load_message
    @message = Message.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def message_params
    params.require(:message).permit(:title, :messages, :phone)
  end

  def render_not_found
    render json: { message: 'Item not found' }, status: :not_found
  end
end
