class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :identifier
      t.string :title
      t.string :description
      t.text :metadata

      t.timestamps
    end
  end

  def self.down
    drop_table :packages
  end
end
