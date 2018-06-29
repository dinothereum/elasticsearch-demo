class ChangeName < ActiveRecord::Migration[5.0]
  def change
    rename_column :articles, :tittle, :title
  end
end
