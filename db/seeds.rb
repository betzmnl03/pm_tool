Member.delete_all
Favourite.delete_all
Comment.delete_all
Discussion.delete_all
Task.delete_all
Project.delete_all
User.delete_all
NUM = rand(1..10)
NUM_TAGS=6
tag=["management","hospitality","finance", "healthcare"]
tag.map do |t|
    Tag.create(
        name:t
    )
end

tags = Tag.all


PASSWORD='supersecret'
super_user= User.create(
    first_name: 'Jon',
    last_name:'Snow',
    email: 'js@winterfell.gov',
    password: PASSWORD,
    is_admin: true
)

4.times do
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

i=0;
j=0
title=["Bootstrap", "PM tool version1","Rank", "Temp", "Tresom", "Opela"]
description = ["create to do app with bootstrap", "Create the version1 of PM tool","create an application to calculate the grade of all the students in the cohort","Create an application to determine the temperature in a particular location","Summer will end soon enough, and childhood as well","Laughter is poison to fear."]
tasks=["requirement gathering","create specifictaion and business requirement docs","review doc","create test case","create test scenario","Requirement Traceablity Matrix","TC Peer Review","Sprint planning","Testing","Retrospective meeting"]
discussion=["sprint planning"]

title.each do |t|
    created_at = Faker::Date.backward(days: 365*5)
    SAMPLE_USER= users.sample
    p = Project.create(
        title: t,
        description:description[i],
        due_date: Faker::Date.forward(days: 23),
        created_at: created_at,
        updated_at: created_at,
        user: SAMPLE_USER
    )
    if p.valid?
        
            p.favouriters = users.shuffle.slice(0,rand(users.count))
     
        p.tasks = tasks.map do |t|
            Task.new(
                title: t,
                completed:Faker::Boolean.boolean, 
                due_date: Faker::Date.forward(days: 60),
                user: users.sample,
                assignee: users.sample.first_name
                # user_first_name: users.sample.first_name
            )    
        end

        p.tags= tags.shuffle.slice(2,rand(tags.count))
        p.users= users.shuffle.slice(1,rand(users.count))
        i+=1
        # p.members=
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