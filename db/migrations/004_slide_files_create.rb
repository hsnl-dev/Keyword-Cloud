require 'sequel'

Sequel.migration do
  change do
    create_table(:slides) do
      String :id, type: :uuid, primary_key: true
      foreign_key :slide_folders_id, :slide_folders

      String :filename
      String :document_encrypted, text: true
      String :checksum, unique: true, text: true
      DateTime :created_at
      DateTime :updated_at

      unique [:filename]
    end
  end
end
