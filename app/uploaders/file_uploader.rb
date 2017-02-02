class FileUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Create different versions of your uploaded files:
  version :thumb, if: :is_image_or_video? do
    process resize_to_fit: [100, 100]
  end

  # transfo pdf/texte avec MiniMagick
  version :pdf_thumb, if: :is_pdf? do
    process :thumbnail_pdf
  end

  def thumbnail_pdf
    manipulate! do |img|
      img.format("png", 0)
      img.resize("100x100")
      img = yield(img) if block_given?
      img
    end
  end

  # redimentionne les images auto si non commenté, sans condition
  # process resize_to_fit: [800, 800]

  # Override the directory where uploaded files will be stored.
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  private

  def is_image_or_video?(file)
     file.content_type.start_with?('image') || file.content_type.start_with?('video')
  end

  def is_pdf?(file)
    file.content_type == "application/pdf"
  end

end
