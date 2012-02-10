class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string :number
      t.timestamps
    end
  end
end
