Sequel.migration do
  change do
    create_table(:potions) do
      primary_key :id
      String :name, null: false, default: 'No name'
    end
  end
end
