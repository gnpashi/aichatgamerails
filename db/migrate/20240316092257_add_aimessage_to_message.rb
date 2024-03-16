class AddAimessageToMessage < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :aimessage, :string
  end
end
