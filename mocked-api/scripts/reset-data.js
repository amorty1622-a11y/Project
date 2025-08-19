import { mkdirSync, writeFileSync } from 'fs'
import { join } from 'path'

const DATA_DIR = join(process.cwd(), 'data')
const DATA_PATH = join(DATA_DIR, 'db.json')

mkdirSync(DATA_DIR, { recursive: true })
const seed = {
  users: [
    { id: 'u1', name: 'diaa', email: 'aa@aa.com', phone: '222', gender: 0, password: 'password' }
  ],
  tokens: {},
  governrates: [ { id: 7, name: 'Cairo' } ],
  cities: [ { id: 7, name: 'Nasr City', governrate_id: 7 } ],
  specializations: [ { id: 1, name: 'Cardiology' } ],
  doctors: [
    { id: 3, name: 'Dr. Finn', city_id: 7, specialization_id: 1, about: 'Heart specialist', rating: 4.8 },
    { id: 5, name: 'Dr. Jane', city_id: 7, specialization_id: 1, about: 'Senior cardiologist', rating: 4.6 }
  ],
  appointments: []
}
writeFileSync(DATA_PATH, JSON.stringify(seed, null, 2))
console.log('Data reset at', DATA_PATH)

