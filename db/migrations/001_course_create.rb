require 'sequel'

Sequel.migration do
  change do
    create_table(:courses) do
      String :id, primary_key: true
      String :course_name
    end
  end
end
