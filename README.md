Example app for <a href="http://stackoverflow.com/questions/39359361/why-does-rails-to-a-mess-with-the-order-of-a-has-many-association/39662534?noredirect=1#comment66660851_39662534">
a Stack Overflow question</a>.

<h3>Setup</h3>

```
bundle install
rake db:setup
rails console
```

<h3>The Question</h3>

The `avatars` association on `User` is supposed to sort by `sort_order` as the scope says

```
has_many :avatars, -> { order([:sort_order => :asc,:created_at => :asc])}
```

However at the console I get a different ordering when using `includes` and `references`.
In fact, in this example I get the incorrect ordering regardless of whether I use `to_a` or not.

In short, I need to understand why the output of these two commands is different (`ap` is just the `awesome_print` gem):

```bash
>> u = User.first
  User Load (0.2ms)  SELECT  "users".* FROM "users"   ORDER BY "users"."id" ASC LIMIT 1
=> #<User id: 1, name: "John", created_at: "2016-09-25 22:11:11", updated_at: "2016-09-25 22:11:11">
>> ap u.avatars
  Avatar Load (0.2ms)  SELECT "avatars".* FROM "avatars"  WHERE "avatars"."user_id" = ?  ORDER BY "avatars"."sort_order" ASC, "avatars"."created_at" ASC  [["user_id", 1]]
[
    [0] #<Avatar:0x007fced316b5a8> {
                :id => 1,
           :user_id => 1,
        :sort_order => 0,
        :created_at => Sun, 25 Sep 2016 22:11:07 UTC +00:00,
        :updated_at => Sun, 25 Sep 2016 22:11:16 UTC +00:00
    },
    [1] #<Avatar:0x007fcece815d40> {
                :id => 3,
           :user_id => 1,
        :sort_order => 1,
        :created_at => Sun, 25 Sep 2016 22:11:11 UTC +00:00,
        :updated_at => Sun, 25 Sep 2016 22:11:12 UTC +00:00
    },
    [2] #<Avatar:0x007fcece815ae8> {
                :id => 2,
           :user_id => 1,
        :sort_order => 2,
        :created_at => Sun, 25 Sep 2016 22:11:09 UTC +00:00,
        :updated_at => Sun, 25 Sep 2016 22:11:14 UTC +00:00
    }
]
=> nil
>> ap User.includes(:avatars, :industries).where(industries: {id: [1]}).references(:industries).first.avatars
  SQL (0.1ms)  SELECT  DISTINCT "users"."id" FROM "users" LEFT OUTER JOIN "avatars" ON "avatars"."user_id" = "users"."id" LEFT OUTER JOIN "user_industries" ON "user_industries"."user_id" = "users"."id" LEFT OUTER JOIN "industries" ON "industries"."id" = "user_industries"."industry_id" WHERE "industries"."id" IN (1)  ORDER BY "users"."id" ASC LIMIT 1
  SQL (0.1ms)  SELECT "users"."id" AS t0_r0, "users"."name" AS t0_r1, "users"."created_at" AS t0_r2, "users"."updated_at" AS t0_r3, "avatars"."id" AS t1_r0, "avatars"."user_id" AS t1_r1, "avatars"."sort_order" AS t1_r2, "avatars"."created_at" AS t1_r3, "avatars"."updated_at" AS t1_r4, "industries"."id" AS t2_r0, "industries"."name" AS t2_r1, "industries"."created_at" AS t2_r2, "industries"."updated_at" AS t2_r3 FROM "users" LEFT OUTER JOIN "avatars" ON "avatars"."user_id" = "users"."id" LEFT OUTER JOIN "user_industries" ON "user_industries"."user_id" = "users"."id" LEFT OUTER JOIN "industries" ON "industries"."id" = "user_industries"."industry_id" WHERE "industries"."id" IN (1) AND "users"."id" IN (1)  ORDER BY "users"."id" ASC
[
    [0] #<Avatar:0x007fced323a128> {
                :id => 1,
           :user_id => 1,
        :sort_order => 0,
        :created_at => Sun, 25 Sep 2016 22:11:07 UTC +00:00,
        :updated_at => Sun, 25 Sep 2016 22:11:16 UTC +00:00
    },
    [1] #<Avatar:0x007fcecd7b7f48> {
                :id => 2,
           :user_id => 1,
        :sort_order => 2,
        :created_at => Sun, 25 Sep 2016 22:11:09 UTC +00:00,
        :updated_at => Sun, 25 Sep 2016 22:11:14 UTC +00:00
    },
    [2] #<Avatar:0x007fcecd7b7b60> {
                :id => 3,
           :user_id => 1,
        :sort_order => 1,
        :created_at => Sun, 25 Sep 2016 22:11:11 UTC +00:00,
        :updated_at => Sun, 25 Sep 2016 22:11:12 UTC +00:00
    }
]
=> nil
>>
```