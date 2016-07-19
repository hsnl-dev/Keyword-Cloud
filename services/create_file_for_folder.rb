# Create new file for a folder
class CreateFileForFolder
  def self.call(folder:, filename:, document:)
    saved_file = folder.add_simple_file(filename: filename)
    saved_file.document = document
    saved_file.save
  end
end
