require 'sequel'

Sequel.migration do
  change do
    create_table(:slide_folders) do
      primary_key :id
      foreign_key :course_id, :courses

      Integer :chapter_order
      String :name
      String :folder_url_encrypted, unique: true
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
