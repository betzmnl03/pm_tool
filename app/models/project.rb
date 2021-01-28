class Project < ApplicationRecord

    has_many :tasks, dependent: :nullify

    has_many :discussions, dependent: :nullify
    # validates :title, presence:true, uniqueness:true 


    has_many :favourites, dependent: :destroy
    has_many :favouriters, through: :favourites, source: :favourites
        # ASSOCIATION WITH USER MODEL
        belongs_to :user, optional: true
end
