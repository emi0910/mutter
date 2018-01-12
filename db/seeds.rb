User.create!(name: "admin",
             password: "adminadmin",
             password_confirmation: "adminadmin",
             admin: true)
UserInfo.create!(description: "Admin",
                 user_id: 1)
