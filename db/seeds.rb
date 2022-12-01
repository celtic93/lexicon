# This file should contain all the record creation needed to seed the database with its default values.
# The data can thnative be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

language = Language.create(name: 'English')

Word.create(native: 'nice', ru: 'хороший', level: 1, rank: 1, locale: 'ru', language_id: language.id)
Word.create(native: 'nice', ru: 'приятный', level: 1, rank: 1, locale: 'ru', language_id: language.id)
Word.create(native: 'present', ru: 'настоящее', level: 1, rank: 2, locale: 'ru', language_id: language.id)
Word.create(native: 'present', ru: 'подарок', level: 1, rank: 2, locale: 'ru', language_id: language.id)
Word.create(native: 'firm', ru: 'фирма', level: 2, rank: 3, locale: 'ru', language_id: language.id)
Word.create(native: 'firm', ru: 'компания', level: 2, rank: 3, locale: 'ru', language_id: language.id)
Word.create(native: 'general', ru: 'общий', level: 2, rank: 4, locale: 'ru', language_id: language.id)
Word.create(native: 'general', ru: 'главный', level: 2, rank: 4, locale: 'ru', language_id: language.id)
Word.create(native: 'sence', ru: 'смысл', level: 3, rank: 5, locale: 'ru', language_id: language.id)
Word.create(native: 'sence', ru: 'чувство', level: 3, rank: 5, locale: 'ru', language_id: language.id)
Word.create(native: 'dark', ru: 'тьма', level: 3, rank: 6, locale: 'ru', language_id: language.id)
Word.create(native: 'dark', ru: 'темнота', level: 3, rank: 6, locale: 'ru', language_id: language.id)
Word.create(native: 'nice', ru: 'хороший', level: 1, rank: 1, locale: 'native', language_id: language.id)
Word.create(native: 'nice', ru: 'приятный', level: 1, rank: 1, locale: 'native', language_id: language.id)
Word.create(native: 'present', ru: 'настоящее', level: 1, rank: 2, locale: 'native', language_id: language.id)
Word.create(native: 'present', ru: 'подарок', level: 1, rank: 2, locale: 'native', language_id: language.id)
Word.create(native: 'firm', ru: 'фирма', level: 2, rank: 3, locale: 'native', language_id: language.id)
Word.create(native: 'firm', ru: 'компания', level: 2, rank: 3, locale: 'native', language_id: language.id)
Word.create(native: 'general', ru: 'общий', level: 2, rank: 4, locale: 'native', language_id: language.id)
Word.create(native: 'general', ru: 'главный', level: 2, rank: 4, locale: 'native', language_id: language.id)
Word.create(native: 'sence', ru: 'смысл', level: 3, rank: 5, locale: 'native', language_id: language.id)
Word.create(native: 'sence', ru: 'чувство', level: 3, rank: 5, locale: 'native', language_id: language.id)
Word.create(native: 'dark', ru: 'тьма', level: 3, rank: 6, locale: 'native', language_id: language.id)
Word.create(native: 'dark', ru: 'темнота', level: 3, rank: 6, locale: 'native', language_id: language.id)
