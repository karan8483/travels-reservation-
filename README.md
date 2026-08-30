# travels-reservation-

# Travel Reservation System - Complete Setup Guide

## Project Overview

This is a full-stack Travel Reservation Management System with:
- **Frontend**: HTML, CSS, JavaScript (web-based)
- **Backend**: Node.js + Express
- **Database**: MySQL
- **Features**: User registration, route search, booking management, admin panel

## Tech Stack Summary

| Component | Technology |
|-----------|------------|
| Frontend | HTML5, CSS3, Vanilla JavaScript |
| Backend | Node.js + Express |
| Database | MySQL |
| Authentication | JWT (JSON Web Tokens) |
| Security | bcryptjs password hashing |
| CORS | Enabled for frontend communication |

## Project Structure

```
travels-reservation-vscode-professional 123/
├── backend/                          # Node.js backend
│   ├── config/
│   │   └── database.js              # MySQL connection
│   ├── middleware/
│   │   └── auth.js                  # JWT authentication
│   ├── routes/
│   │   ├── auth.js                  # Register, Login
│   │   ├── routes.js                # Travel routes CRUD
│   │   ├── bookings.js              # Booking management
│   │   ├── buses.js                 # Bus management
│   │   └── users.js                 # User management
│   ├── server.js                    # Express app entry
│   ├── package.json                 # Dependencies
│   ├── .env.example                 # Environment template
│   ├── database.sql                 # MySQL schema
│   └── SETUP.md                     # Backend setup guide
├── js/                              # API Integration scripts
│   ├── auth-api.js                  # Authentication functions
│   ├── search-api.js                # Route search
│   ├── booking-api.js               # Booking form
│   ├── bookings-api.js              # My bookings page
│   └── admin-api.js                 # Admin dashboard
├── css/                             # Stylesheets
│   └── style.css
├── html pages (API versions)
│   ├── register-api.html            # User registration
│   ├── login-api.html               # User login
│   ├── search-api.html              # Search routes
│   ├── booking-api.html             # Book ticket
│   ├── my-bookings-api.html         # View bookings
│   └── admin-api.html               # Admin dashboard
└── Original files (localStorage versions)
    ├── index.html, register.html, login.html
    ├── search.html, booking.html, my-bookings.html
    └── admin.html
```

## Quick Start

### Phase 1: Setup MySQL Database

1. **Start MySQL Server**
   ```bash
   # Windows
   net start MySQL80
   
   # Or use MySQL Workbench
   ```

2. **Create Database**
   ```bash
   mysql -u root -p
   ```

3. **Import Database Schema**
   ```sql
   source backend/database.sql
   ```

### Phase 2: Setup Backend

1. **Navigate to backend folder**
   ```bash
   cd backend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment**
   ```bash
   cp .env.example .env
   ```
   
   Edit `.env`:
   ```
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=your_mysql_password
   DB_NAME=travel_reservation
   JWT_SECRET=your_secure_secret_key_change_this
   PORT=5000
   NODE_ENV=development
   ```

4. **Start backend server**
   ```bash
   npm run dev
   ```
   
   Server runs on: `http://localhost:5000`

### Phase 3: Update Frontend HTML Files

Replace old links in HTML files:
- Change `login.html` → `login-api.html`
- Change `register.html` → `register-api.html`
- Change `search.html` → `search-api.html`
- Change `booking.html` → `booking-api.html`
- Change `my-bookings.html` → `my-bookings-api.html`
- Change `admin.html` → `admin-api.html`

### Phase 4: Run Frontend

1. **Install Live Server extension in VS Code**

2. **Right-click `index.html` → Open with Live Server**

3. **Frontend runs on**: `http://127.0.0.1:5500` (or similar)

## API Endpoints Reference

### Authentication
```
POST /api/auth/register
POST /api/auth/login
POST /api/auth/logout
```

### Routes
```
GET    /api/routes                  # Get all routes (filter: ?from=&to=)
GET    /api/routes/:id              # Get single route
POST   /api/routes                  # Create route (admin)
PUT    /api/routes/:id              # Update route (admin)
DELETE /api/routes/:id              # Delete route (admin)
```

### Bookings
```
GET    /api/bookings                # Get user's bookings (auth required)
GET    /api/bookings/:id            # Get single booking (auth required)
POST   /api/bookings                # Create booking (auth required)
PUT    /api/bookings/:id/cancel     # Cancel booking (auth required)
GET    /api/bookings/admin/all      # Get all bookings (admin only)
```

### Buses
```
GET    /api/buses                   # Get all buses
GET    /api/buses/:id               # Get single bus
POST   /api/buses                   # Create bus (admin)
PUT    /api/buses/:id               # Update bus (admin)
DELETE /api/buses/:id               # Delete bus (admin)
```

### Users
```
GET    /api/users/profile           # Get current user (auth required)
PUT    /api/users/profile           # Update profile (auth required)
GET    /api/users                   # Get all users (admin only)
```

## Authentication Flow

1. **User Registration** (POST /api/auth/register)
   - Frontend sends: name, email, password
   - Backend: Hashes password, stores in MySQL
   - Response: Success message

2. **User Login** (POST /api/auth/login)
   - Frontend sends: email, password
   - Backend: Verifies credentials
   - Response: JWT token + user data
   - Frontend: Stores token in localStorage

3. **API Requests with Auth**
   ```javascript
   Authorization: Bearer <jwt_token>
   ```
   - Token is attached to all authenticated requests
   - Backend middleware verifies token validity
   - Token expires in 24 hours

## Sample Test Credentials

After running `database.sql`:

| Role | Email | Password | Notes |
|------|-------|----------|-------|
| Admin | admin@example.com | admin123 | Create via SQL script |
| Customer | Any registered | Their password | Register via app |

## Important Frontend Functions

All functions are in `/js/*-api.js` files:

### auth-api.js
- `apiRequest()` - Make API calls with auth token
- `getToken()` / `setToken()` - Manage JWT
- `getCurrentUser()` / `setCurrentUser()` - Manage user session
- `showMessage()` - Display notifications
- `requireAuth()` - Check authentication
- `logout()` - Logout user

### search-api.js
- `searchRoutes()` - Search routes by cities
- `displayRoutes()` - Render search results
- `selectRoute()` - Select route for booking

### booking-api.js
- `loadRouteDetails()` - Display selected route
- `submitBooking()` - Create booking
- `generateSeatNumbers()` - Generate seat options

### bookings-api.js
- `loadMyBookings()` - Fetch user's bookings
- `displayBookings()` - Render bookings
- `cancelBooking()` - Cancel a booking

### admin-api.js
- `loadDashboard()` - Load statistics
- `addBus()` / `loadBuses()` / `deleteBus()` - Manage buses
- `addRoute()` / `loadRoutes()` / `deleteRoute()` - Manage routes
- `viewAllBookings()` - View all customer bookings

## Common Issues & Fixes

### Issue: "Cannot connect to database"
```
Check:
- MySQL is running
- Database credentials in .env are correct
- Database 'travel_reservation' exists
- Port 3306 is accessible
```

### Issue: CORS errors in browser
```
Already handled in backend. If issues persist:
- Ensure backend is running on :5000
- Update API_BASE_URL in auth-api.js if port differs
- Check browser console for specific errors
```

### Issue: "Token expired" on API calls
```
User's JWT token has expired (24 hours).
Solution: User must login again.
Modify token expiry in backend/routes/auth.js if needed.
```

### Issue: Admin features not visible
```
Check:
- Logged in user has role='admin'
- Token is valid
- User was created with admin role
```

## Deployment Checklist

Before production:

- [ ] Change JWT_SECRET to a strong random string
- [ ] Use HTTPS for all API calls
- [ ] Add rate limiting to auth endpoints
- [ ] Implement CSRF protection
- [ ] Add input validation on all endpoints
- [ ] Set NODE_ENV=production
- [ ] Use strong MySQL password
- [ ] Setup automated backups
- [ ] Add logging and monitoring
- [ ] Implement payment gateway integration
- [ ] Add PDF export functionality (see below)

## Adding PDF/Excel Export

### For PDF Export (Add to bookings-api.js):
```javascript
// Install: npm install jspdf
async function exportPDF(bookingId) {
  const doc = new jsPDF();
  doc.text('Booking Ticket', 10, 10);
  // ... add booking details ...
  doc.save(`ticket-${bookingId}.pdf`);
}
```

### For Excel Export (Add to admin-api.js):
```javascript
// Install: npm install xlsx
function exportExcel(bookings) {
  const worksheet = XLSX.utils.json_to_sheet(bookings);
  const workbook = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(workbook, worksheet, 'Bookings');
  XLSX.writeFile(workbook, 'bookings.xlsx');
}
```

## Next Steps

1. ✅ Complete backend setup with Node.js + Express + MySQL
2. ✅ Create API endpoints
3. ✅ Create API integration JavaScript files
4. ✅ Create new HTML pages using API
5. Add PDF/Excel export functionality
6. Add email notifications
7. Add payment gateway (Razorpay/Stripe)
8. Add real-time seat availability updates
9. Deploy to production (Heroku/AWS/Azure)
10. Setup CI/CD pipeline

## Support & Troubleshooting

1. **Check backend logs**: Look at terminal running `npm run dev`
2. **Check browser console**: Press F12, go to Console tab
3. **Check Network tab**: See actual API requests and responses
4. **Test API directly**: Use Postman or curl:
   ```bash
   curl http://localhost:5000/api/health
   ```

## Additional Resources

- [Express.js Documentation](https://expressjs.com/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [JWT Guide](https://jwt.io/)
- [REST API Best Practices](https://restfulapi.net/)

 ## Image
<img width="1886" height="1079" alt="Screenshot 2026-08-25 202454" src="https://github.com/user-attachments/assets/6bcf4ba2-42b5-4e8f-88c9-996e054ed72c" />

---
