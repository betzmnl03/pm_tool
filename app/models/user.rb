class User < ApplicationRecord


    has_many :projects, dependent: :nullify
    has_many :tasks, dependent: :nullify
    has_many :discussions, dependent: :nullify
    has_many :comments, dependent: :nullify
    has_secure_password

    has_many :favourites, dependent: :destroy
    has_many :favourited_projects, through: :favourites, source: :project


    def full_name

        "#{first_name} #{last_name}"
    end
end
