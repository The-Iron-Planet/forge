class AddCommentEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :get_comment_email, :boolean
  end
end
