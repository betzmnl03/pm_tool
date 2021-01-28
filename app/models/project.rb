class Project < ApplicationRecord

    has_many :tasks, dependent: :nullify

    has_many :discussions, dependent: :nullify
    # validates :title, presence:true, uniqueness:true 


    has_many :favourites, dependent: :destroy
    has_many :favouriters, through: :favourites, source: :user
        # ASSOCIATION WITH USER MODEL
        belongs_to :user, optional: true


    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    has_many :members, dependent: :destroy
    has_many :users, through: :members


    def user_first_names
        self.users.map(&:first_name).join(', ')
    end

    def user_first_names=(rhs)
        self.users=rhs.strip.split(/\s*,\s*/).map do|user_first_name|
            User.find_or_initialize_by(first_name: user_first_name)
        end
    end



end
