class MessagesController < ApplicationController

  def create
    @chask = Chask.find(params[:chask_id])
    @message = Message.new(message_params)
    authorize @message
    @message.chask = @chask
    @message.user = current_user
    if @message.save
      # @response = chat_get_reply(@message.content)
      ChatroomChannel.broadcast_to(
        @chask,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.user.id
      )
      head :ok
      response = OpenaiService.new(@message.content).call
      reply = Message.new(content: response, user: User.chatgpt, chask: @chask)
      if reply.save
        ChatroomChannel.broadcast_to(
          @chask,
          message: render_to_string(partial: "message", locals: { message: reply }),
          sender_id: reply.user.id
        )
        head :ok
      end
    else
      render "chasks/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  # def chat_get_reply(user_prompt)
  #   response = OpenaiService.new(user_prompt).call
  #   message = Message.create!(content: response, user: User.chatgpt)
  #   raise
  #   return message
  # end
end

# if @message.save
#   response = OpenaiService.new(@message.content).call
#   Message.create(content: response, chask: @message.chask, user: YOUR_CHATGPT_USER)
# else
#   render "chasks/show", status: :unprocessable_entity
# end
