# Create new file
class CreateConcepts
  def self.call(course_id:, document:)
    if Concept.where(course_id: course_id).first != nil
      updated_file = Concept.where(course_id: course_id).first
      updated_file.document = document
      updated_file.save
    else
      saved_file = Concept.new()
      saved_file.course_id = course_id
      saved_file.document = document
      saved_file.save
    end
  end
end
