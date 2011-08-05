# Example migration for the ActiveScaffoldListFilter model
class CreateActiveScaffoldListFilters < ActiveRecord::Migration
  def self.up
    create_table :active_scaffold_list_filters do |t|
      t.column :type, :string
      t.string :name
      t.integer :user_id
      t.text :filter
      t.timestamps
    end
  end

  def self.down
    drop_table :active_scaffold_list_filters
  end
end
