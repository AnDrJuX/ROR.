class AddUserIdToTickets < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :tickets
  end
end
