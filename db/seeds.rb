# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Favourite.delete_all
Comment.delete_all
Discussion.delete_all
Task.delete_all
Project.delete_all
User.delete_all
NUM = rand(1..10)


PASSWORD='supersecret'
super_user= User.create(
    first_name: 'Jon',
    last_name:'Snow',
    email: 'js@winterfell.gov',
    password: PASSWORD,
    is_admin: true
)

10.times do
    first_name= Faker::Name.first_name 
    last_name= Faker::Name.last_name 
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name}.#{last_name}@example.com",
        password: PASSWORD
    )
end
users=User.all

NUM.times do
    created_at = Faker::Date.backward(days: 365*5)
    SAMPLE_USER= users.sample
    p = Project.create(
        title: Faker::Commerce.product_name,
        description:Faker::Commerce.color,
        due_date: Faker::Date.forward(days: 23),
        created_at: created_at,
        updated_at: created_at,
        user: SAMPLE_USER
    )
    if p.valid?
        p.tasks = NUM.times.map do
            Task.new(
                title: Faker::Verb.base,
                completed:Faker::Boolean.boolean, 
                due_date: Faker::Date.forward(days: 60),
                user: users.sample
            )
                
        end
    end

    if p.valid?
        p.discussions = NUM.times.map do 
            Discussion.new(
                title:Faker::TvShows::BigBangTheory.character,
                body: Faker::TvShows::BigBangTheory.quote,
                user: users.sample
            )

        end
        p.discussions.each do |discussion|
            
            NUM.times.map do 
                Comment.create(
                discussion_id: discussion.id,
                body: Faker::TvShows::BigBangTheory.quote,
                user: users.sample
            )
            end
        end
    end
    puts p.errors.full_messages
end

project = Project.all
task = Task.all
discussions = Discussion.all
comments = Comment.all

puts Cowsay.say("Generated #{project.count} projects", :dragon)
puts Cowsay.say("Generated #{task.count} tasks", :frogs)
puts Cowsay.say("Generated #{discussions.count} discussions", :beavis)
puts Cowsay.say("Generated #{comments.count} comments", :dragon)