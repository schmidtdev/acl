class CreateJwtDenyllists < ActiveRecord::Migration[7.2]
  def change
    create_table :jwt_denyllists do |t|
      t.string :jti
      t.datetime :exp

      t.timestamps
    end
    add_index :jwt_denyllists, :jti
  end
end
