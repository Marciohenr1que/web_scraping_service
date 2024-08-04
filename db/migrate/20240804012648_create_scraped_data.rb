class CreateScrapedData < ActiveRecord::Migration[7.1]
  def change
    create_table :scraped_data do |t|
      t.string :brand
      t.string :model
      t.decimal :price
      t.string :url

      t.timestamps
    end
  end
end
