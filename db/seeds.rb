art_industry = Industry.create(name: "Art")
music_industry = Industry.create(name: "Music")

avatar_one = Avatar.create(sort_order: 0)
sleep(2) # makes timestamps more distinguishable
avatar_two = Avatar.create(sort_order: 2)
sleep(2)
avatar_three = Avatar.create(sort_order: 1)

john = User.create(name: "John")
john.industries = [art_industry, music_industry]
john.avatars << avatar_three
sleep(2)
john.avatars << avatar_two
sleep(2)
john.avatars << avatar_one
# since avatars scope sorts by sort_order
# john.avatars.pluck(:id) returns (1,3,2)
