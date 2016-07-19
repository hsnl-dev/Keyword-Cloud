require 'sequel'
require 'json'

# Holds and persists an account's information
class Course < Sequel::Model
  # plugin :single_table_inheritance, :type
  one_to_one :course_concepts,
              class: :Concept,
              key: :course_id

  one_to_many :course_slide_folders,
               class: :SlideFolder,
               key: :course_id

  def to_json(options = {})
    JSON({  type: 'courses',
            id: id,
            course_name: course_name
          },
         options)
  end
end
