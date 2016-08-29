Sequel.migration do
  up do
    create_table(:headers) do
      primary_key :id
      foreign_key :message_id, :messages
      String :name
      String :value
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:headers)
  end
end
