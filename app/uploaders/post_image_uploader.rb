class PostImageUploader < ImageUploader

  # Process files as they are uploaded:
  process :resize_to_fit => [600, 600]
  
  # Create different versions of your uploaded files:
  version :iphone do
    process :resize_to_fit => [400, 400]
  end  

end
