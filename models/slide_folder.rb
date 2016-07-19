require 'json'
require 'sequel'

# Holds a Folder's information
class SlideFolder < Sequel::Model
  plugin :timestamps, update_on_create: true

  one_to_many :slide_files,
              class: :Slide,
              key: :slide_folders_id

  many_to_one :course, class: :Course

  plugin :association_dependencies, slide_files: :destroy

  def folder_url
    SecureDB.decrypt(folder_url_encrypted)
  end

  def folder_url=(folder_url_plaintext)
    self.folder_url_encrypted = SecureDB.encrypt(folder_url_plaintext) if folder_url_plaintext
  end

  def to_json(options = {})
    JSON({  type: 'folder',
            id: id,
            attributes: {
              course_id: course_id,
              chapter_order: chapter_order,
              name: name,
              folder_url: folder_url
            }
          },
         options)
  end
end