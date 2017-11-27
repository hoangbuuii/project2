class CommentMailer < ActionMailer::Base
  def comment_created(current_user, comment)
    @current_user = current_user
    @comment = comment
    mail(to: comment.post.user.email, from: "gordonstormberg@gmail.com", subject: t(".comment_created_subject"))
  end
end
