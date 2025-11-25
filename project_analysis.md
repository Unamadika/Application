# Sahara Travel App Project Analysis

## Overview
The project consists of a **Flutter frontend** (`sahara_travel_app`) and a **Node.js/Express backend** (`sahara-server-main`).

## Backend: `sahara-server-main`
**Tech Stack:** Node.js, Express, MongoDB, Mongoose, JWT.

### Directory Structure
- **`src/`**: Source code.
  - **`configs/`**: Configuration files (likely DB connection).
  - **`controllers/`**: Request handling logic.
    - `authController.js`: Handles Login/Register.
    - `bookingController.js`: Handles Booking operations.
    - `trekController.js`: Handles Trek operations.
  - **`middleware/`**: Middleware functions (Auth, Error handling).
  - **`models/`**: Database schemas.
    - `userModel.js`: User schema (supports `user` and `guide` roles).
    - `trekModel.js`: Trek schema.
    - `bookingModel.js`: Booking schema.
  - **`routes/`**: API route definitions.
    - `authRoutes.js`: `/auth/login`, `/auth/register`.
    - `bookingRoutes.js`: Booking endpoints.
    - `trekRoutes.js`: Trek endpoints.
- **`index.js`**: Application entry point.
- **`package.json`**: Dependencies and scripts.

### Current Status
- **Implemented**: Authentication, Treks, Bookings.
- **Missing**: Chat, Groups, Safety Alerts, Events, Payment processing.

## Frontend: `sahara_travel_app`
**Tech Stack:** Flutter, GetX (State Management & Navigation).

### Directory Structure (`lib/`)
- **`controllers/`**: GetX Controllers for UI logic.
  - `login_controller.dart`, `register_controller.dart`: Handle Auth.
  - `home_controller.dart`: Manages Home screen data.
  - `chat_controller.dart`, `group_controller.dart`, etc.: Manage feature-specific data.
- **`data/`**: Static data.
  - `dummy_content.dart`: Contains mock data for Treks, Events, Guides, Chat, Groups, etc.
- **`models/`**: Data models.
  - `trip.dart`, `guide.dart`, `message.dart`, `safety_alert.dart`, etc.
  - **Note**: More models exist here than in the backend.
- **`services/`**: Data fetching services.
  - `api_service.dart`: **Connects to Backend**. Handles Login/Register.
  - `travel_service.dart`: Uses **Mock Data**. Fetches Treks, Events, Guides.
  - `chat_service.dart`: Uses **Mock Data**. Fetches Chat history.
  - `payment_service.dart`: Uses **Mock Data**.
  - `safety_service.dart`: Uses **Mock Data**.
- **`ui/`**: User Interface.
  - `screens/`: Application screens (Home, Login, Chat, etc.).
  - `widgets/`: Reusable UI components.
  - `theme/`: App styling.

### Current Status
- **Authentication**: Fully integrated with the backend.
- **Other Features**: UI is implemented but powered by **Mock Data** (`DummyContent`). The backend does not yet support Chat, Groups, Safety, or Events.

## Integration Gaps
| Feature | Frontend Status | Backend Status | Integration |
| :--- | :--- | :--- | :--- |
| **Auth** | Ready | Ready | ✅ Connected |
| **Treks** | Ready (Mock Data) | Ready (API exists) | ❌ Not Connected |
| **Bookings** | UI Pending | Ready (API exists) | ❌ Not Connected |
| **Chat** | Ready (Mock Data) | ❌ Missing | ❌ Not Connected |
| **Groups** | Ready (Mock Data) | ❌ Missing | ❌ Not Connected |
| **Safety** | Ready (Mock Data) | ❌ Missing | ❌ Not Connected |
| **Events** | Ready (Mock Data) | ❌ Missing | ❌ Not Connected |
