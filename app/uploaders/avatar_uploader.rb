class AvatarUploader < ImageUploader

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/assets/thumbnail_no_avatar.png"
  end
  
  # Process files as they are uploaded:
  process :resize_to_fit => [600, 600]
  
  # Create different versions of your uploaded files:
  version :thumbnail do
    process :resize_to_fill => [50, 50]
  end  

  # version :profile do
  #   process :resize_to_fill => [300, 300]
  # end  

end
