class CreateProtocols < ActiveRecord::Migration
  def change
    create_table :protocols do |t|
      t.string :number

      t.timestamps
    end
  end
end
