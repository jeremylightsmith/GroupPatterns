Dir.chdir(File.dirname(__FILE__) + "/Cards") do 
  Dir["*.jpg"].each do |image|
    cmd = "convert #{image} -resize 100x100^ -gravity center -extent 100x100 small/#{image.sub(".jpg", "_small.jpg")}"
    `#{cmd}`
  end
end