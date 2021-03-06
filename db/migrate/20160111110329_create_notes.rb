class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :language_id
      t.string :title
      t.text :body
      t.text :source
      t.boolean :question
      t.boolean :private
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
