# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pang    = Family.create(family_name: 'Pang')
lam     = Family.create(family_name: 'Lam')
heimann = Family.create(family_name: 'Heimann')

# heimann family
User.create(first_name: 'Dennis',
            last_name: 'Smith',
            role: 'patient',
            family: lam)
sue  = User.create(first_name: 'Sue',
            last_name: 'Lam',
            role: 'caretaker',
            family: lam)
alec = User.create(first_name: 'Alec',
            last_name: 'Lam',
            role: 'caretaker',
            family: lam)
User.create(first_name: 'Jackie',
            last_name: 'Fung',
            role: 'doctor',
            family: lam)

# pang family
User.create(first_name: 'Priscilla',
            last_name: 'Wong',
            role: 'patient',
            family: pang)
User.create(first_name: 'Stephanie',
            last_name: 'Pang',
            role: 'caretaker',
            family: pang)
User.create(first_name: 'Jonathan',
            last_name: 'Ho',
            role: 'doctor',
            family: pang)

# heimann family
User.create(first_name: 'Jane',
            last_name: 'Doe',
            role: 'patient',
            family: heimann)
User.create(first_name: 'John',
            last_name: 'Doe',
            role: 'caretaker',
            family: heimann)
larry = User.create(first_name: 'Larry',
            last_name: 'Heimann',
            role: 'caretaker',
            family: heimann)

# questions
Question.create(question: 'Who is this?',
                answer: 'Alec Lam',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/alec.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Frank Liao',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/frank.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Gary Dilisio',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/gary.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Jordan Stapinski',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/jordan.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Stephanie Pang',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/steph.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Jose Vazquez',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/jose.png").open)
Question.create(question: 'Who is this?',
                answer: 'Rudy Wolfs',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/rudy.png").open)
Question.create(question: 'Who is this?',
                answer: 'Prof H',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/profh.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Prof Raja',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/raja.jpg").open)
Question.create(question: 'Where is this?',
                answer: 'Capital One Bank',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/capital-one.jpg").open)
Question.create(question: 'Where is this?',
                answer: 'Carnegie Mellon University',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/cmu.jpg").open)
Question.create(question: 'Where is this?',
                answer: 'Gates Hillman Center',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/gates.jpg").open)
Question.create(question: 'Where is this?',
                answer: 'Hunt Library',
                created_by: larry.id,
                attachment: Rails.root.join("db/images/hunt.jpg").open)


# lam family questions
Question.create(question: 'Who is this?',
                answer: 'Alec Lam',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/alec.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Dr. Econopouley',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/drEconopouley.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Dr. Joseph',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/drJoseph.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Dr. Stein',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/drStein.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Evan Lam',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/evan.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Gladys',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/gladys.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Jeff',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/jeff.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Joy (nurse)',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/joyNurse.jpg").open)
Question.create(question: 'Where is this?',
                answer: 'The pharmacy',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/pharmacy.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Sharon (Neighbor)',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/sharonNeighbor.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Sharton',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/sharton.jpg").open)
Question.create(question: 'Who is this?',
                answer: 'Sue Lam',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/sue.jpg").open)
Question.create(question: 'Where is this?',
                answer: "Trader Joe's",
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/traderJoes.jpg").open)
Question.create(question: 'What is this?',
                answer: 'Voting',
                created_by: sue.id,
                attachment: Rails.root.join("db/images/dennis/votingMemory.jpg").open)

