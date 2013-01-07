class Attachment < ActiveRecord::Base
  attr_accessible :post_id, :url, :image, :description
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  belongs_to :post
  
  before_post_process :image?  # skip post_process if not image file
  def image?
    !(image_content_type =~ /^image.*/).nil?
  end
  
end
