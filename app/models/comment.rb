class Comment < ActiveRecord::Base
  attr_accessible :note, :post_id, :user_id, :stock_id
  belongs_to :post
end
