# Extracts width and height in pixels from an image blob.
#
# If the image contains EXIF data indicating its angle is 90 or 270 degrees, its width and height are swapped for convenience.
#
# Example:
#
#   ActiveStorage::Analyzer::ImageAnalyzer.new(blob).metadata
#   # => { width: 4104, height: 2736 }
#
# This analyzer relies on the third-party {MiniMagick}[https://github.com/minimagick/minimagick] gem. MiniMagick requires
# the {ImageMagick}[http://www.imagemagick.org] system library.
defmodule ActiveStorage.Analyzer.ImageAnalyzer do
  def accept?(blob) do
    blob.image?
  end

  def metadata(blob) do
    # read_image do |image|
    #   if rotated_image?(image)
    #     { width: image.height, height: image.width }
    #   else
    #     { width: image.width, height: image.height }
    #   end
    # end
  end

  def read_image(blob) do
    #  download_blob_to_tempfile do |file|
    #    require "mini_magick"
    #    image = MiniMagick::Image.new(file.path)

    #    if image.valid?
    #      yield image
    #    else
    #      logger.info "Skipping image analysis because ImageMagick doesn't support the file"
    #      {}
    #    end
    #  end
    # rescue LoadError
    #  logger.info "Skipping image analysis because the mini_magick gem isn't installed"
    #  {}
    # rescue MiniMagick::Error => error
    #  logger.error "Skipping image analysis due to an ImageMagick error: #{error.message}"
    #  {}
  end

  def rotated_image?(image) do
    ["RightTop", "LeftBottom"] |> Enum.member?(image["%[orientation]"])
  end
end
