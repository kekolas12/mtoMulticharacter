Config = Config or {}

Config.CanDelete = true
Config.CharacterSlot = 4

Config.StarterItems = {
    ['phone'] = {amount = 1, item = 'phone'},
    ['id_card'] = {amount = 1, item = 'id_card'},
    ['driver_license'] = {amount = 1, item = 'driver_license'},
    ['kurkakola'] = {amount = 5, item = 'kurkakola'},
    ['sandwich'] = {amount = 5, item = 'sandwich'},
}

Config.SpawnLocations = {
    vector3(-207.79, 6427.62, 31.55),
    vector3(-189.31, 6416.91, 31.86),
    vector3(2611.24, 4530.71, 36.43),
    vector3(-19.95, -1573.02, 29.29),
    vector3(132.67, -1444.83, 29.29),
    vector3(225.27, -100.67, 69.88),
    vector3(63.84, 324.53, 112.1),
    vector3(-783.77, 185.59, 72.84),
    vector3(-1729.82, -188.01, 58.35),
    vector3(3809.64, 4471.2, 4.03),
    vector3(3327.62, 5153.97, 18.32),
    vector3(-3095.42, 341.63, 14.44)
}

Config.CustomCharacterSlot = {
    ["license:1c98c1f296be02730c8bc0f398c63eb121cdcc1f"] = 3
}

Config.CamPosition = {
    x = -0.3,
    y = 3.8,
    z = 0.2
}

Config.Lang = 'tr'

Config.Locale = {
    ['en'] = {
        loaded_text = '^2[qb-core]^7 %s has succesfully loaded!',
        ui = {
            gender = 'Gender',
            birthday = 'Date Of Birthday',
            money = 'Money',
            phone_number = 'Phone Number',
            grade = 'Grade',
            nationality = 'Nationality',
            gangs = 'Gangs',
            not_gang = 'This character is not part of any formation.',
            delete = 'Delete',
            select = 'Confirm',
            cancel = 'Cancel',
            firstname = 'Firstname',
            lastname = 'Lastname',
            create = 'Create',
            new_character = 'New Character',
            male = 'Male',
            female = 'Female',
            loading = 'Character loading...'
        }
    },
    ['tr'] = {
        loaded_text = '^2[qb-core]^7 %s basarıyla yuklendi!',
        ui = {
            gender = 'Cinsiyet',
            birthday = 'Doğum Tarihi',
            money = 'Para',
            phone_number = 'Telefon Numarası',
            grade = 'Rütbe',
            nationality = 'Uyruk',
            delete = 'Sil',
            select = 'Seç',
            cancel = 'İptal',
            firstname = 'Ad',
            lastname = 'Soyad',
            create = 'Oluştur',
            new_character = 'Yeni Karakter',
            male = 'Erkek',
            female = 'Kadın',
            loading = 'Karakterler yükleniyor...'
        }
    }
}