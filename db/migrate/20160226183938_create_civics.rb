class CreateCivics < ActiveRecord::Migration
  def change
    create_table :civics do |t|

      t.timestamps null: false
    end
  end
end
