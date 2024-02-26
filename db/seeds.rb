# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "csv"

csv_text = File.read(Rails.root.join('db', 'products.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'UTF-8')
csv.each do |row|
  category_name = row['category']
  category = Category.find_or_create_by(name: category_name)
  Product.create(title: row['title'], description: row['description'], price: row['price'], stock_quantity: row['stock_quantity'], category: category)
end
