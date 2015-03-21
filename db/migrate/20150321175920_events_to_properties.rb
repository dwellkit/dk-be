class EventsToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :event_id, :integer
  end
end
