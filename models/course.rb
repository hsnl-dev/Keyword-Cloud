require 'sequel'
require 'json'

# Holds and persists an account's information
class Course < Sequel::Model
  def to_json(options = {})
    JSON({  type: 'courses',
            data: {
              id: id,
              course_name: course_name
            }
          },
         options)
  end
end
