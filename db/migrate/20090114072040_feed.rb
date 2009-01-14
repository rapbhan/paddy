class Feed < ActiveRecord::Migration
  def self.up
      create_table :feeds do |t|
		t.string :title, :link, :guid, :category, :pubDate
		t.text :description
		t.timestamps
    end
  end

  def self.down
  end
end
