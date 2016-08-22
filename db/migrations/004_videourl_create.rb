require 'sequel'

Sequel.migration do
  change do
    create_table(:videourls) do
      primary_key :id
      foreign_key :owner_id, :courses

      String :chapter_id
      String :chapter_order
      String :video_id
      Integer :video_order
      String :name
      String :video_url, unique: true
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
