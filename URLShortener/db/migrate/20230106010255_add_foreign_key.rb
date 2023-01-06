class AddForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_column :shortened_urls, :submitter_id, :integer ,null: false
    add_index :shortened_urls, :submitter_id, unique: true
  end
end
