class AddNicknameToCurricula < ActiveRecord::Migration
  def change
    add_column :curricula, :nickname, :string
  end
end
