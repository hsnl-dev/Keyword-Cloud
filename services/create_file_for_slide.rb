# Create new file for a folder
class CreateFileForSlide
  def self.call(folder:, filename:, document:)
    saved_file = folder.add_slide_file(filename: filename)
    saved_file.document = document
    saved_file.save
  end
end
