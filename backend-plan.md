# Backend Implementation Plan (Firebase-first)

## Goal
Build a secure, scalable backend foundation for the marketplace app using Firebase, with:
- Authentication and authorization
- Core marketplace data and business workflows
- Push notifications

## Proposed Architecture
- **Identity**: Firebase Authentication (email/password first, social login optional later)
- **Authorization**: Role-based access with Firebase custom claims (`customer`, `seller`, `admin`) + Firestore Security Rules
- **Database**: Cloud Firestore for users, products, carts, orders, chats, notifications
- **Server Logic**: Cloud Functions (Node.js + TypeScript) for trusted workflows and event-driven automation
- **Push**: Firebase Cloud Messaging (FCM), token registration per device, notification dispatch from Cloud Functions
- **Files**: Firebase Storage for listing images and optional profile assets
- **Protection & Ops**: App Check, Firebase Emulator Suite, structured logging, staged environments (dev/staging/prod)

## Phase Plan

### 1. Foundation Setup
1. Create Firebase projects (dev/staging/prod) and link app IDs.
2. Initialize Firebase services: Auth, Firestore, Functions, Storage, FCM.
3. Add environment/config strategy (separate keys/config per environment).
4. Set up local development with Firebase Emulator Suite.

**Deliverable:** Firebase projects and local backend runtime are operational.

### 2. Domain Model & Security Baseline
1. Define Firestore collections and document schemas:
   - `users`, `shops`, `products`, `carts`, `orders`, `conversations`, `messages`, `deviceTokens`, `notifications`
2. Define ownership and access matrix per role.
3. Implement first-pass Firestore Security Rules.
4. Add indexes for expected query patterns.

**Deliverable:** Data model and security rules support safe read/write boundaries.

### 3. Auth & Authorization
1. Implement sign-up/sign-in/sign-out flows with Firebase Auth.
2. Add role assignment strategy:
   - Default role on registration
   - Admin-only promotion/demotion flow via callable Cloud Function
3. Issue and refresh custom claims.
4. Enforce role checks in both Security Rules and Functions.

**Deliverable:** Users can authenticate and are correctly restricted by role.

### 4. Core Backend Workflows
1. Implement callable/HTTP Functions for protected actions (e.g., create listing, place order, update order state).
2. Move sensitive business logic out of client-side code.
3. Add validation, idempotency guards, and consistent error contracts.
4. Add audit-friendly timestamps and actor metadata.

**Deliverable:** Critical marketplace flows are server-controlled and secure.

### 5. Push Notifications
1. Add device token registration/update/removal flow.
2. Trigger FCM notifications from Functions for key events:
   - Order placed/accepted/rejected/shipped
   - New chat message
   - Listing lifecycle updates
3. Add user notification preferences (opt-in categories).
4. Persist notification records in Firestore for in-app inbox/history.

**Deliverable:** Reliable event-based push notifications with preference handling.

### 6. Reliability, Testing, and Release
1. Add automated tests for Security Rules and Functions (emulator-based).
2. Add monitoring/alerts for Functions errors and delivery failures.
3. Create deployment scripts/pipeline for staged rollout.
4. Document runbooks for incident response and rollback.

**Deliverable:** Backend is testable, observable, and production-ready.

## Initial Technical Decisions
- Prefer **Cloud Functions + Firestore rules** over direct client writes for sensitive operations.
- Keep role model minimal at first (`customer`, `seller`, `admin`) and extend only when required.
- Treat notifications as both **push events** and **stored records** for UX reliability.

## Suggested Execution Order for First Sprint
1. Firebase project setup + emulator
2. Firestore schema draft + security rules V1
3. Auth integration + role claims
4. First protected flow: create product listing
5. First notification flow: order placed

## Out of Scope for Initial Backend Start
- Full analytics pipeline
- Recommendation engine
- Complex search indexing outside Firestore native capabilities
