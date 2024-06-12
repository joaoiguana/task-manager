class Task < ApplicationRecord
  belongs_to :bucket

  def self.get_by_status(status)
    where(status:)
  end
end
