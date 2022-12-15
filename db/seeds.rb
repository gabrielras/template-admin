#####################################

manager_permission = ManagerPermission.find_or_create_by(
  name: 'Administração - Perfis'
)

PermissionToUser.find_or_create_by(
  name: 'Visualizar',
  manager_permission: manager_permission,
  actions: ['user/admin/offices#index']
)
PermissionToUser.find_or_create_by(
  name: 'Criar',
  manager_permission: manager_permission,
  actions: %w[user/admin/offices#new user/admin/users#create]
)
PermissionToUser.find_or_create_by(
  name: 'Editar',
  manager_permission: manager_permission,
  actions: %w[user/admin/offices#edit user/admin/users#update]
)
PermissionToUser.find_or_create_by(
  name: 'Destruir',
  manager_permission: manager_permission,
  actions: %w[user/admin/offices#destroy]
)

#####################################

manager_permission = ManagerPermission.find_or_create_by(
  name: 'Administração - Usuários'
)

PermissionToUser.find_or_create_by(
  name: 'Visualizar',
  manager_permission: manager_permission,
  actions: ['user/admin/users#index']
)
PermissionToUser.find_or_create_by(
  name: 'Criar',
  manager_permission: manager_permission,
  actions: %w[user/admin/users#new user/admin/users#create]
)
PermissionToUser.find_or_create_by(
  name: 'Editar',
  manager_permission: manager_permission,
  actions: %w[user/admin/users#edit user/admin/users#update]
)

PermissionToUser.find_or_create_by(
  name: 'Remover',
  manager_permission: manager_permission,
  actions: %w[user/admin/users#destroy]
)

#####################################

User.create!(full_name: 'admin', cpf: '046.447.810-37', email: 'admin@admin.com', phone_number: '85 99999-9999', password: '123456')
office = Office.find_or_create_by(name: "Admin")

role = Role.create!(office: office, user: User.first)

PermissionToUser.all.each do |permission_to_user|
  OfficePermission.find_or_create_by(
    office: office,
    permission_to_user: permission_to_user
  )
end
