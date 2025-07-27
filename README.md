# International Media Academic Society - Spring Legacy CRUD

A comprehensive Spring Legacy web application built with MyBatis and JSP, featuring student and article management systems. This project is a clone of the original Spring Boot application, redesigned using traditional Spring Framework technologies.

## 🚀 Features

### Core Functionality
- **Student Management System**: Complete CRUD operations for student records
- **Article Management System**: Full-featured content management with categories
- **Category Management**: Organize articles by topics with hierarchical structure
- **Search & Pagination**: Advanced search capabilities with paginated results
- **Responsive Design**: Mobile-friendly interface using Bootstrap 5

### Technical Features
- **Spring Legacy Framework**: Traditional Spring MVC architecture
- **MyBatis Integration**: SQL mapping framework for database operations
- **JSP Views**: Server-side rendered pages with JSTL
- **RESTful API**: JSON endpoints for programmatic access
- **Database Support**: MySQL/MariaDB and H2 in-memory database
- **Transaction Management**: Declarative transaction support

## 🛠 Technology Stack

### Backend
- **Java 17**: Modern LTS Java version
- **Spring Framework 5.3.39**: Core Spring libraries
  - Spring MVC: Web framework
  - Spring JDBC: Database integration
  - Spring TX: Transaction management
- **MyBatis 3.5.16**: SQL mapping framework
- **Maven**: Build automation and dependency management

### Frontend
- **JSP & JSTL**: Server-side templating
- **Bootstrap 5.3.0**: CSS framework
- **jQuery 3.6.4**: JavaScript library
- **Bootstrap Icons**: Icon library

### Database
- **MySQL 8.0** / **MariaDB**: Primary production database
- **H2 2.2.220**: In-memory database for testing
- **Connection Pooling**: Apache Commons DBCP2

## 📋 Prerequisites

- Java 17 or higher
- Maven 3.6+ 
- MySQL 8.0+ or MariaDB 10.3+ (for production)
- IDE (IntelliJ IDEA, Eclipse, or VS Code)
- Web browser (Chrome, Firefox, Safari, Edge)

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone <repository-url>
cd spring-legacy-crud
```

### 2. Database Setup

#### Option A: MySQL/MariaDB (Recommended for Production)
```sql
-- Create database
CREATE DATABASE school CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create user (optional)
CREATE USER 'spring_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON school.* TO 'spring_user'@'localhost';
FLUSH PRIVILEGES;
```

Update `src/main/resources/database.properties`:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/school?useSSL=false&serverTimezone=UTC
db.username=root
db.password=your_password
```

#### Option B: H2 In-Memory Database (Quick Testing)
No setup required - database runs in memory.

### 3. Build and Run

#### Using Maven with Jetty Plugin
```bash
# Clean and compile
mvn clean compile

# Run with embedded Jetty server
mvn jetty:run
```

#### Using External Application Server
```bash
# Build WAR file
mvn clean package

# Deploy to Tomcat, Jetty, or other servlet container
cp target/international-media-legacy.war $TOMCAT_HOME/webapps/
```

### 4. Access the Application
- **Web Interface**: http://localhost:8080
- **Admin Panel**: http://localhost:8080/admin
- **API Endpoints**: http://localhost:8080/api/*

## 📁 Project Structure

```
spring-legacy-crud/
├── src/
│   ├── main/
│   │   ├── java/com/handong/internationalmedia/
│   │   │   ├── controller/          # Web controllers
│   │   │   │   ├── HomeController.java
│   │   │   │   ├── StudentController.java
│   │   │   │   ├── StudentRestController.java
│   │   │   │   └── AdminController.java
│   │   │   ├── service/             # Business logic
│   │   │   │   ├── StudentService.java
│   │   │   │   ├── ArticleService.java
│   │   │   │   └── CategoryService.java
│   │   │   ├── dao/                 # Data access objects
│   │   │   │   ├── StudentDao.java
│   │   │   │   ├── ArticleDao.java
│   │   │   │   └── CategoryDao.java
│   │   │   ├── model/               # Domain models
│   │   │   │   ├── Student.java
│   │   │   │   ├── Article.java
│   │   │   │   └── Category.java
│   │   │   └── dto/                 # Data transfer objects
│   │   │       ├── StudentDto.java
│   │   │       └── ArticleDto.java
│   │   ├── resources/
│   │   │   ├── mappers/             # MyBatis XML mappers
│   │   │   │   ├── StudentMapper.xml
│   │   │   │   ├── ArticleMapper.xml
│   │   │   │   └── CategoryMapper.xml
│   │   │   ├── mybatis-config.xml   # MyBatis configuration
│   │   │   ├── database.properties  # Database settings
│   │   │   ├── schema.sql           # Database schema
│   │   │   └── data.sql             # Sample data
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── views/           # JSP views
│   │       │   │   ├── layout/      # Common layouts
│   │       │   │   ├── students/    # Student views
│   │       │   │   ├── articles/    # Article views
│   │       │   │   └── admin/       # Admin views
│   │       │   ├── spring/          # Spring configuration
│   │       │   │   ├── root-context.xml
│   │       │   │   └── servlet-context.xml
│   │       │   └── web.xml          # Web application descriptor
│   │       ├── css/
│   │       │   └── custom.css       # Custom styles
│   │       └── js/
│   │           └── custom.js        # Custom JavaScript
│   └── test/                        # Test classes
├── pom.xml                          # Maven configuration
└── README.md                        # This file
```

## 🎯 Key Features

### Student Management
- **CRUD Operations**: Create, read, update, delete students
- **Search & Filter**: Search by name or email with pagination
- **Data Validation**: Client and server-side validation
- **Export Functionality**: CSV export capabilities
- **REST API**: Programmatic access via JSON endpoints

### Article Management
- **Content Creation**: Rich article creation with categories
- **Publishing System**: Draft and published states
- **Featured Articles**: Highlight important content
- **View Tracking**: Article view count tracking
- **Category Organization**: Hierarchical content organization

### Admin Interface
- **Dashboard**: Overview statistics and recent activity
- **Bulk Operations**: Manage multiple records simultaneously
- **Content Moderation**: Publish/unpublish articles
- **Category Management**: Create and organize content categories

## 📡 API Endpoints

### Student API
```
GET    /api/students              # Get all students (paginated)
GET    /api/students/{id}         # Get student by ID
POST   /api/students              # Create new student
PUT    /api/students/{id}         # Update student
DELETE /api/students/{id}         # Delete student
GET    /api/students/search       # Search students
PATCH  /api/students/{id}/name    # Update student name
PATCH  /api/students/{id}/email   # Update student email
GET    /api/students/stats        # Get student statistics
```

### Example API Usage
```bash
# Get all students
curl -X GET http://localhost:8080/api/students

# Create new student
curl -X POST http://localhost:8080/api/students \
  -H "Content-Type: application/json" \
  -d '{"name":"John Doe","email":"john@example.com"}'

# Search students
curl -X GET "http://localhost:8080/api/students/search?keyword=john&page=0&size=10"
```

## 🔧 Configuration

### Database Configuration
Edit `src/main/resources/database.properties`:
```properties
# MySQL/MariaDB Configuration
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/school?useSSL=false&serverTimezone=UTC
db.username=root
db.password=your_password

# H2 Configuration (for testing)
h2.driver=org.h2.Driver
h2.url=jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE
h2.username=sa
h2.password=
```

### MyBatis Configuration
The MyBatis configuration in `mybatis-config.xml` includes:
- Automatic camelCase mapping
- Type aliases for model classes
- Caching enabled
- Lazy loading configuration

### Spring Configuration
- **Root Context** (`root-context.xml`): Core beans, database, MyBatis
- **Servlet Context** (`servlet-context.xml`): Web MVC, view resolvers, static resources

## 📊 Database Schema

### Students Table
```sql
CREATE TABLE students (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### Categories Table
```sql
CREATE TABLE categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(500),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### Articles Table
```sql
CREATE TABLE articles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    summary VARCHAR(500),
    author VARCHAR(100),
    featured_image VARCHAR(500),
    read_time INT,
    view_count BIGINT DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    is_published BOOLEAN DEFAULT FALSE,
    category_id BIGINT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);
```

## 🧪 Testing

### Running Tests
```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=StudentServiceTest

# Run with specific profile
mvn test -Dspring.profiles.active=test
```

### Test Database
Tests use H2 in-memory database for isolation and speed.

## 🚀 Deployment

### Production Deployment

1. **Build the application**:
```bash
mvn clean package -Dmaven.test.skip=true
```

2. **Configure production database**:
   - Update `database.properties` with production credentials
   - Ensure database server is running and accessible

3. **Deploy WAR file**:
   - Copy `target/international-media-legacy.war` to your application server
   - Configure server context path and database connections

4. **Initialize database**:
   - Run `schema.sql` to create tables
   - Optionally run `data.sql` for sample data

### Docker Deployment (Optional)
```dockerfile
FROM tomcat:9-jdk17
COPY target/international-media-legacy.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
```

## 🔒 Security Considerations

- **SQL Injection Prevention**: MyBatis parameterized queries
- **Input Validation**: Client and server-side validation
- **CORS Configuration**: Configurable cross-origin policies
- **Error Handling**: Graceful error pages and logging

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Errors**:
   - Check database server is running
   - Verify credentials in `database.properties`
   - Ensure database exists and is accessible

2. **Build Failures**:
   - Verify Java 17+ is installed
   - Check Maven configuration
   - Clear Maven repository: `mvn dependency:purge-local-repository`

3. **JSP Compilation Issues**:
   - Ensure servlet container supports JSP 2.3+
   - Check JSTL dependencies are included

4. **MyBatis Mapping Errors**:
   - Verify XML mapper syntax
   - Check SQL compatibility with target database
   - Enable MyBatis logging for debugging

### Logging Configuration
Add to `logback.xml` for debugging:
```xml
<logger name="com.handong.internationalmedia" level="DEBUG"/>
<logger name="org.mybatis" level="DEBUG"/>
<logger name="org.springframework" level="INFO"/>
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-feature`
3. Commit changes: `git commit -am 'Add new feature'`
4. Push to branch: `git push origin feature/new-feature`
5. Submit a pull request

### Code Style
- Follow Java naming conventions
- Use meaningful variable and method names
- Add JavaDoc for public methods
- Write unit tests for new features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Spring Legacy Team** - *Initial work and architecture*
- **International Media Academic Society** - *Requirements and specifications*

## 🙏 Acknowledgments

- Original Spring Boot project: `2025s-web-service-project2-keilvher1`
- Spring Framework team for excellent documentation
- MyBatis team for the powerful SQL mapping framework
- Bootstrap team for the responsive CSS framework

## 📞 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the troubleshooting section above

---

**Happy Coding! 🚀**