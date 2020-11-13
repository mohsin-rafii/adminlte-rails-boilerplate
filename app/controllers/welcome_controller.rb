class WelcomeController < ApplicationController
  def home
    #it is giving all authors , but we dont need all of them..
    @authors = User.where(role: "author")
    #we onyl need the one who are subscribed by the reader.
    if current_user
      user = User.where(id: current_user.id)
      @subscribed_authors = user.first.subscribers
    end
  end

  def change_subscribe_status
    #if the subscribed button is pressed
    #get the auhtor id
    #find current user id
    #make the changes
    if (params[:choice_type] == "follow")
      user_status = UserSubscriber.new
      user_status.user_id = current_user.id
      user_status.subscriber_id = User.find(params[:author_id]).id
      user_status.save
    else
      user_status = UserSubscriber.find_by(user_id: current_user.id , subscriber_id: params[:author_id])
      user_status.delete
      user = User.find(params[:author_id])
      user_comments = Comment.where(user_id: current_user.id , post_id: user.posts.ids)
      user_comments.delete_all
    end
    #now it will go to the action method first by using redirect_to
    redirect_to action: "home"
  end
end
