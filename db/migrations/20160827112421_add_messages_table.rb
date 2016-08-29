Sequel.migration do
  up do
    create_table(:messages) do
      primary_key :id
      foreign_key :queue_id, :queues
      String :body, text: true
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:messages)
  end
end
