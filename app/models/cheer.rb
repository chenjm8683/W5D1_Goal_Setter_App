class Cheer < ActiveRecord::Base
  MAX_CHEERS = 5

  validates :user_id, :goal_id, presence: true
  validates_uniqueness_of :user_id, scope: :goal_id
  validate :within_max_count

  belongs_to :user
  belongs_to :goal

  def cheers_given_count
    cheer_count = Cheer.where(user_id: self.user_id).count
  end

  def within_max_count
    if cheers_given_count >=  MAX_CHEERS
      errors.add(:count, "Already gave out max amount of cheers")
    end
  end
end
