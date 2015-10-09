user_1 = User.create(email: 'knoxjeffrey@outlook.com', password: 'password', full_name: "Jeff Knox")
user_2 = User.create(email: 'knoxjeffrey@hotmail.com', password: 'password', full_name: "Hazel Knox")

project_1 = Project.create(admin: user_1, project_name: "TAMARS")
project_2 = Project.create(admin: user_1, project_name: "Primate")

UserProject.create(user: user_1, project: project_1)
UserProject.create(user: user_2, project: project_1)
UserProject.create(user: user_1, project: project_2)