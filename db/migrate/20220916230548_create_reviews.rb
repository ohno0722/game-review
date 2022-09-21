class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer:user_id
      t.float:rate
      t.string:title
      t.text:body
      t.string:category

      t.timestamps
    end
  end
end
