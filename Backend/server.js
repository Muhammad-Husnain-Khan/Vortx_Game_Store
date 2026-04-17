const express = require('express');
const cors = require('cors');
const { connectDB } = require('./config/db');

const app = express();
const PORT = process.env.PORT || 5000;

// =============================================
// Middleware
// =============================================
app.use(cors({
  origin: 'http://localhost:5173',  // Vite dev server
  credentials: true
}));
app.use(express.json({ limit: '10mb' }));

// =============================================
// API Routes (v1)
// =============================================
const authRoutes = require('./routes/authRoutes');
const gameRoutes = require('./routes/gameRoutes');
const orderRoutes = require('./routes/orderRoutes');
const reviewRoutes = require('./routes/reviewRoutes');
const wishlistRoutes = require('./routes/wishlistRoutes');
const libraryRoutes = require('./routes/libraryRoutes');
const adminRoutes = require('./routes/adminRoutes');
const categoryRoutes = require('./routes/categoryRoutes');

app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/games', gameRoutes);
app.use('/api/v1/orders', orderRoutes);
app.use('/api/v1/reviews', reviewRoutes);
app.use('/api/v1/wishlist', wishlistRoutes);
app.use('/api/v1/library', libraryRoutes);
app.use('/api/v1/admin', adminRoutes);
app.use('/api/v1/categories', categoryRoutes);

// =============================================
// Health Check
// =============================================
app.get('/', (req, res) => {
  res.json({ message: 'Vortx Game Store API v1.0', status: 'running' });
});

// =============================================
// Error Handling
// =============================================
app.use((err, req, res, next) => {
  console.error('Server Error:', err.message);
  res.status(500).json({ error: 'Internal server error' });
});

// =============================================
// Start Server
// =============================================
async function startServer() {
  await connectDB();
  app.listen(PORT, () => {
    console.log(`🚀 Vortx API running on http://localhost:${PORT}`);
  });
}

startServer();
