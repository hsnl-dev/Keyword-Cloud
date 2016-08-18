require 'sequel'

Sequel.migration do
  change do
    create_table(:courses) do
      primary_key :id

      String :course_id, unique: true
      String :course_name
    end
  end
end
