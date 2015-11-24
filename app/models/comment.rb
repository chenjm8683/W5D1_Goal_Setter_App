class Comment < ActiveRecord::Base
  validates :body, :commentable_id, :commentable_type, :author_id, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: 'User'

  belongs_to :commentable, polymorphic: true

end
