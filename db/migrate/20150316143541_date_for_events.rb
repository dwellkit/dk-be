class DateForEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_date, :datetime
    add_column :events, :event_frequency, :string
  end
end
