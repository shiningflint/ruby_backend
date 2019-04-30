Sequel.migration do
  change do
    add_column :potions, :description, String
  end
end
