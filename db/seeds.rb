
10.times do 
    if  Faker::Config.random.seed.even?
        open_to_work = true
    else
        open_to_work = false
    end


    first_user = User.create(linkedin_handle: Faker::Internet.username(specifier: 5..8), name: Faker::Name.unique.name, email: Faker::Internet.email)
    first_user.work_preference.update(open_to_targeted_jobs: true, willing_to_relocate: false)
    second_user = User.create(linkedin_handle: Faker::Internet.username(specifier: 5..8), name: Faker::Name.unique.name, email: Faker::Internet.email)
    second_user.work_preference.update(open_to_targeted_jobs: true, willing_to_relocate: false)

    6.times do
        first_user.outbound_nominations.create.nominated = second_user
        first_user.inbound_nominations.create.nominator = second_user
    end
end