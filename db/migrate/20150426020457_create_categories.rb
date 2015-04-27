class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :label
    end
  end
end
