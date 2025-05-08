# Hospital Database - SQL Server Project

This project is a comprehensive, role-based hospital database system built using **Microsoft SQL Server**. It models key entities such as patients, doctors, prescriptions, insurance, and user roles, with support for **views**, **stored procedures**, and **triggers**.

## 📦 Project Structure

| File                        | Description                                                  |
|----------------------------|--------------------------------------------------------------|
| `hbd_schema.sql`            | Creates all necessary tables (patients, doctors, prescriptions, etc.) |
| `hbd_sample_data.sql`       | Inserts mock data for testing                                 |
| `hbd_views_and_procedures.sql` | Defines views, stored procedures, and a trigger for appointment validation |


## 🔧 Features

- Normalized relational schema
- Role-based access via `Users`, `Roles`, and `User_Roles` tables
- Intelligent views for:
  - Doctors (appointments, prescriptions)
  - Nurses (medications and allergies)
  - Receptionists (insurance tracking, appointment history)
- Stored procedures for:
  - Booking appointments
  - Viewing patient prescriptions
  - Checking active insurance
  - Role-based view access
- Trigger that blocks appointment booking with insurance if no valid insurance exists


## 🧪 How to Run
1. Open SQL Server Management Studio (SSMS)
2. Run `hbd_schema.sql` to initalize database and create tables
3. Run `hbd_sample_data.sql` to populate the database
4. Run `hbd_views_and_procedures.sql` to define logic and security


## ✅ Requirements
- Microsoft SQL Server (2019+ recommended)
- SSMS or a compatible query tool
- Basic understanding of SQL


## 🚀 Future Improvements
- Add frontend UI
- Integrate appointment scheduling calendar
- Add patient login and digital health records interface

## 📝 Hospital ERD

![Hospital ERD](docs/Hospital_ERD.PNG)


## 🤝 Contributing
Contributions are welcome! If you’d like to improve this project or add features:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature-name`)
3. Commit your changes (`git commit -m 'Add feature'`)
4. Push to your branch (`git push origin feature/your-feature-name`)
5. Open a Pull Request

Please follow SQL and naming best practices. For major changes, open an issue first to discuss what you’d like to propose.
