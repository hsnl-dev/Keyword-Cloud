require 'sequel'

Sequel.migration do
  change do
    create_table(:concepts) do
      String :id, type: :uuid, primary_key: true
      foreign_key :course_id, :courses

      String :document_encrypted, text: true
      String :checksum, unique: true, text: true
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
