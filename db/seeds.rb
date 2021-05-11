
30.times do 
    if  Faker::Config.random.seed.even?
        open_to_work = true
    else
        open_to_work = false
    end


    first_user = User.create(linkedin_handle: Faker::Internet.username(specifier: 5..8), name: Faker::Name.unique.name, email: Faker::Internet.email, open_to_work: open_to_work)
    second_user = User.create(linkedin_handle: Faker::Internet.username(specifier: 5..8), name: Faker::Name.unique.name, email: Faker::Internet.email, open_to_work: open_to_work)
    6.times do
        first_user.outbound_nominations.create.nominated = second_user
        first_user.inbound_nominations.create.nominator = second_user
    end
end