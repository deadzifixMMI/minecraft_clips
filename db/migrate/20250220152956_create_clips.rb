class CreateClips < ActiveRecord::Migration[8.0]
  def change
    create_table :clips do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :video_url

      t.timestamps
    end
  end
end
