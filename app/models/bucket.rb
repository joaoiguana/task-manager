class Bucket < ApplicationRecord
  has_many :tasks, dependent: :destroy

  def self.get_by_status(status)
    where(status: status)
  end

  def update_status
    if self.tasks.empty?
      self.update(status: "Empty")
    elsif self.tasks.any? { |task| task.status == "Pending" }
      self.update(status: "Pending")
    else
      self.update(status: "Completed")
    end
  end

  def tasks_by_status(status)
    tasks.where(status: status)
  end
end
