class Discussion < ApplicationRecord
    has_many :comments, dependent: :nullify;

    belongs_to :project
    belongs_to :user, optional: true
end
