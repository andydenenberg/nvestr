namespace :images do
require 'RMagick'
  desc "Resize Images"
    task :resize do
      
      dir = Dir.glob("app/assets/images/groundbreaking/*")
      puts dir.count
      dir.each_with_index do |pic,i|
        img = Magick::Image::read(pic).first
        small = img.resize_to_fit(200,200)
        puts i.to_s + ': ' + pic
        small.write(pic.sub!('.jpg','_s.jpg'))
      end
    end
end