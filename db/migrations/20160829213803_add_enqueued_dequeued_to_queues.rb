Sequel.migration do
  up do
    alter_table(:queues) do
      add_column :enqueued, Integer, default: 0
      add_column :dequeued, Integer, default: 0
    end
  end

  down do
    alter_table(:queues) do
      drop_column :enqueued
      drop_column :dequeued
    end
  end
end
