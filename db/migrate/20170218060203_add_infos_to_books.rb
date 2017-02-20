class AddInfosToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :active, :boolean, :default => true
    add_column :books, :code, :string
  end
end
