class CreatePrincipals < ActiveRecord::Migration
  def change
    create_table :principals do |t|
      t.string :protokoll_number

      t.timestamps
    end
  end
end
