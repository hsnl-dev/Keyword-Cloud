require 'sequel'

Sequel.migration do
  change do
    create_table(:folders) do
      primary_key :id
      # foreign_key :owner_id, :courses
      String :course_id
      String :folder_type
      String :chapter_id
      String :chapter_order
      String :name
      String :folder_url_encrypted, unique: true
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
