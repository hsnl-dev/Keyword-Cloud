require 'sequel'

Sequel.migration do
  change do
    create_table(:folders) do
      primary_key :id

      Integer :course_id
      String :folder_type
      Integer :chapter_id
      Integer :chapter_order
      String :name
      String :folder_url_encrypted, unique: true
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
