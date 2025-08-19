import express from 'express'
import cors from 'cors'
import morgan from 'morgan'
import { readFileSync, writeFileSync, existsSync, mkdirSync } from 'fs'
import { join } from 'path'
import { nanoid } from 'nanoid'

const DATA_DIR = join(process.cwd(), 'data')
const DATA_PATH = join(DATA_DIR, 'db.json')

function ensureDataFile() {
  if (!existsSync(DATA_DIR)) {
    mkdirSync(DATA_DIR, { recursive: true })
  }
  if (!existsSync(DATA_PATH)) {
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
  }
}

function loadDb() {
  ensureDataFile()
  return JSON.parse(readFileSync(DATA_PATH, 'utf-8'))
}

function saveDb(db) {
  writeFileSync(DATA_PATH, JSON.stringify(db, null, 2))
}

const app = express()
app.use(cors())
app.use(morgan('dev'))
app.use(express.urlencoded({ extended: true }))
app.use(express.json())

const api = express.Router()

function ok(res, body) {
  res.json({ message: 'OK', data: body, status: true, code: 200 })
}

function unprocessable(res, errors) {
  res.status(422).json({ message: 'Unprocessable Entity', data: errors, status: false, code: 422 })
}

function requireAuth(req, res, next) {
  const auth = req.headers.authorization || ''
  const token = auth.startsWith('Bearer ') ? auth.slice(7) : null
  const db = loadDb()
  if (!token || !db.tokens[token]) {
    return res.status(401).json({ message: 'Unauthorized', data: [], status: false, code: 401 })
  }
  req.userId = db.tokens[token]
  next()
}

// Auth Module
api.post('/auth/register', (req, res) => {
  const { name, email, phone, gender, password, password_confirmation } = req.body
  const errors = {}
  if (!name) errors.name = ['The name field is required.']
  if (!email) errors.email = ['The email field is required.']
  if (!phone) errors.phone = ['The phone field is required.']
  if (gender === undefined || gender === null || gender === '') errors.gender = ['The sex field is required.']
  if (!password) errors.password = ['The password field is required.']
  if (password && password_confirmation && password !== password_confirmation) errors.password_confirmation = ['The password confirmation does not match.']
  if (Object.keys(errors).length) return unprocessable(res, errors)
  const db = loadDb()
  if (db.users.find(u => u.email === email)) return unprocessable(res, { email: ['The email has already been taken.'] })
  const id = nanoid()
  db.users.push({ id, name, email, phone, gender: Number(gender), password })
  const token = nanoid()
  db.tokens[token] = id
  saveDb(db)
  res.json({ message: 'Loggedin Successfuly.', data: { token, username: name }, status: true, code: 200 })
})

api.post('/auth/login', (req, res) => {
  const { email, password } = req.body
  const db = loadDb()
  const user = db.users.find(u => u.email === email && u.password === password)
  if (!user) return res.status(401).json({ message: 'Invalid credentials', data: [], status: false, code: 401 })
  const token = nanoid()
  db.tokens[token] = user.id
  saveDb(db)
  res.json({ message: 'Loggedin Successfuly.', data: { token, username: user.name }, status: true, code: 200 })
})

api.post('/auth/logout', requireAuth, (req, res) => {
  const auth = req.headers.authorization
  const token = auth.startsWith('Bearer ') ? auth.slice(7) : null
  const db = loadDb()
  if (token && db.tokens[token]) {
    delete db.tokens[token]
    saveDb(db)
  }
  res.json({ message: 'Loggedout Successfuly', data: [], status: true, code: 200 })
})

// User Module
api.get('/user/profile', requireAuth, (req, res) => {
  const db = loadDb()
  const user = db.users.find(u => u.id === req.userId)
  ok(res, user)
})

api.post('/user/update', requireAuth, (req, res) => {
  const { name, email, phone, gender, password } = req.body
  const db = loadDb()
  const user = db.users.find(u => u.id === req.userId)
  if (!user) return res.status(404).json({ message: 'Not Found', data: [], status: false, code: 404 })
  if (name !== undefined) user.name = name
  if (email !== undefined) user.email = email
  if (phone !== undefined) user.phone = phone
  if (gender !== undefined) user.gender = Number(gender)
  if (password) user.password = password
  saveDb(db)
  ok(res, user)
})

// Home Module
api.get('/home/index', requireAuth, (req, res) => {
  const db = loadDb()
  ok(res, {
    banners: [
      { id: 'b1', title: 'Welcome to VCare', image: 'banner1.png' },
      { id: 'b2', title: 'Find top doctors', image: 'banner2.png' }
    ],
    recommendations: db.doctors.slice(0, 5)
  })
})

// Governrate Module
api.get('/governrate/index', requireAuth, (req, res) => {
  const db = loadDb()
  ok(res, db.governrates)
})

// City Module
api.get('/city/index', requireAuth, (req, res) => {
  const db = loadDb()
  ok(res, db.cities)
})

api.get('/city/show/:govId', requireAuth, (req, res) => {
  const db = loadDb()
  const list = db.cities.filter(c => String(c.governrate_id) === String(req.params.govId))
  ok(res, list)
})

// Specialization Module
api.get('/specialization/index', requireAuth, (req, res) => {
  const db = loadDb()
  ok(res, db.specializations)
})

api.get('/specialization/show/:id', requireAuth, (req, res) => {
  const db = loadDb()
  const spec = db.specializations.find(s => String(s.id) === String(req.params.id))
  ok(res, spec)
})

// Doctor Module
api.get('/doctor/index', requireAuth, (req, res) => {
  const db = loadDb()
  ok(res, db.doctors)
})

api.get('/doctor/show/:id', requireAuth, (req, res) => {
  const db = loadDb()
  const doc = db.doctors.find(d => String(d.id) === String(req.params.id))
  ok(res, doc)
})

api.get('/doctor/doctor-filter', requireAuth, (req, res) => {
  const { city, specialization } = req.query
  const db = loadDb()
  let list = db.doctors
  if (city) list = list.filter(d => String(d.city_id) === String(city))
  if (specialization) list = list.filter(d => String(d.specialization_id) === String(specialization))
  ok(res, list)
})

api.get('/doctor/doctor-search', requireAuth, (req, res) => {
  const { name } = req.query
  const db = loadDb()
  const q = (name || '').toLowerCase()
  const list = db.doctors.filter(d => d.name.toLowerCase().includes(q))
  ok(res, list)
})

// Appointment Module
api.get('/appointment/index', requireAuth, (req, res) => {
  const db = loadDb()
  const list = db.appointments.filter(a => a.user_id === req.userId)
  ok(res, list)
})

api.post('/appointment/store', requireAuth, (req, res) => {
  const { doctor_id, start_time, notes } = req.body
  const errors = {}
  if (!doctor_id) errors.doctor_id = ['The doctor_id field is required.']
  if (Object.keys(errors).length) return unprocessable(res, errors)
  const db = loadDb()
  const doctor = db.doctors.find(d => String(d.id) === String(doctor_id))
  if (!doctor) return unprocessable(res, { doctor_id: ['Doctor not found.'] })
  const appointment = {
    id: nanoid(),
    user_id: req.userId,
    doctor_id: Number(doctor_id),
    start_time: start_time || new Date().toISOString(),
    notes: notes || ''
  }
  db.appointments.push(appointment)
  saveDb(db)
  ok(res, appointment)
})

app.use('/api', api)

const PORT = process.env.PORT || 5050
app.listen(PORT, () => {
  console.log(`Mock VCare API listening on http://localhost:${PORT}/api`)
})

