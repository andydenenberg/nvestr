class Post < ActiveRecord::Base
  has_many :attachments, :dependent => :destroy
  attr_accessible :body, :title, :user_id, :type_is, :attachments_attributes, :comments_attributes
  has_many :comments, :dependent => :destroy
  has_one :user
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  accepts_nested_attributes_for :comments, :allow_destroy => true
  
  def file_count(kind)
        
    count = 0
    stash = [ ]
    case kind
    when 'image'
      self.attachments.each do |fn|
        if !fn.image_content_type.nil? and fn.image_content_type.include?('image')
          count =+ 1
          stash.push fn
        end
      end        
    when 'file'
      self.attachments.each do |fn|
        if !fn.image_content_type.nil? and !fn.image_content_type.include?('image')
          count =+ 1
          stash.push fn
        end
      end      
    when 'url'
      self.attachments.each do |attach|
        if attach.image_file_name.nil?
          count =+ 1
          stash.push attach
        end
      end      
    end
    
    return count, stash      	    
  end
  
end
